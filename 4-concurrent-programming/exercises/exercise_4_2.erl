-module(exercise_4_2).

-export([start/3, loop/3]).

start(M, N, Message) ->
    io:format("~p", [self()]),
    LPid = start(M, N, Message, self()),
    LPid ! {self(), Message},
    io:format(" <<< ~p\n", [self()]),
    loop(M, Message, LPid).

start(_M, 1, _Message, PPid) ->
    PPid;
start(M, N, Message, PPid) ->
    Pid = spawn(exercise_4_2, loop, [M, Message, PPid]),
    io:format(" <<< ~p", [Pid]),
    start(M, N - 1, Message, Pid).

send(Dest, Msg) ->
    io:format("Pid ~p sends ~p to Pid ~p~n", [self(), Msg, Dest]),
    Dest ! {self(), Msg}.

stop(Dest) ->
    send(Dest, 'STOP').

loop(M, Message, Dest) ->
    receive
        {From, 'STOP'} ->
            io:format("Pid ~p gets _~p_ from Pid ~p~n", [self(), 'STOP', From]),
            stop(Dest);
        {_From, Message} ->
            if
                M == 1 ->
                    io:format("Pid ~p is the first process to stop!\n", [self()]),
                    stop(Dest);
                M > 1 ->
                    send(Dest, Message),
                    loop(M - 1, Message, Dest)
            end
    end.