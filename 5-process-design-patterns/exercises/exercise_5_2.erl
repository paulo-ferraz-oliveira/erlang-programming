-module(exercise_5_2).

-export([start/0, stop/0, allocate/0, deallocate/1]).
-export([init/0]).

-export([keycount/3]).

%% These are the start functions used to create and
%% initialize the server.

start() -> register(exercise_5_2, spawn(exercise_5_2, init, [])).

init() ->
    Frequencies = {get_frequencies(), []},
    loop(Frequencies).

% Hard Coded

get_frequencies() -> [10, 11, 12, 13, 14, 15].

%% The client Functions

stop() ->
    case call(stop) of
        ok -> true;
        {error, Reply} -> Reply
    end.

allocate() -> call(allocate).

deallocate(Freq) -> call({deallocate, Freq}).

%% We hide all message passing and the message
%% protocol in a functional interface.

call(Message) ->
    exercise_5_2 ! {request, self(), Message},
    receive
        {reply, Reply} -> Reply
    end.

%% The Main Loop
loop(Frequencies) ->
    receive
        {request, Pid, allocate} ->
            {NewFrequencies, Reply} = allocate(Frequencies, Pid),
            reply(Pid, Reply),
            loop(NewFrequencies);
        {request, Pid , {deallocate, Freq}} ->
            {NewFrequencies, Reply} = deallocate(Frequencies, Freq, Pid),
            reply(Pid, Reply),
            loop(NewFrequencies);
        {request, Pid, stop} ->
            case Frequencies of
                {_, []} ->
                    reply(Pid, ok);
                _ ->
                    reply(Pid, {error, allocated_still}),
                    loop(Frequencies)
            end
    end.

reply(Pid, Reply) -> Pid ! {reply, Reply}.

%% The Internal Help Functions used to allocate and
%% deallocate frequencies.

keycount(Key, N, TupleList) -> keycount(Key, N, TupleList, 0).

keycount(_Key, _N, [], Acc) ->
    Acc;
keycount(Key, N, [H | T], Acc) ->
    case element(N, H) == Key of
        true -> keycount(Key, N, T, Acc + 1);
        false -> keycount(Key, N, T, Acc)
    end.

allocate({[], Allocated}, _Pid) -> {{[], Allocated}, {error, no_frequency}};
allocate({[Freq | Free], Allocated}, Pid) ->
    AllocNb = keycount(Pid, 2, Allocated),
    if
        AllocNb < 3 -> {{Free, [{Freq, Pid} | Allocated]}, {ok, Freq}};
        true -> {{[Freq | Free], Allocated}, {error, maxed_out}}
    end.

deallocate({Free, Allocated}, Freq, Pid) ->
    case lists:keyfind(Freq, 1, Allocated) of
        false ->
            Reply = {error, not_found},
            NewAllocated = Allocated;
        Tuple ->
            case Tuple of
                {Freq, Pid} ->
                    Reply = {ok, Freq},
                    NewAllocated = lists:keydelete(Freq, 1, Allocated);
                _ ->
                    Reply = {error, not_authorized},
                    NewAllocated = Allocated
            end
    end,
    {{[Freq | Free], NewAllocated}, Reply}.