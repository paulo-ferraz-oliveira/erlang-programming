-module(exercise_6_3).

-export([start_link/2, stop/1]).
-export([init/1]).

start_link(Name, ChildSpecList) ->
    register(Name, spawn_link(exercise_6_3, init, [ChildSpecList])),
    ok.

init(ChildSpecList) ->
    process_flag(trap_exit, true),
    loop(start_children(ChildSpecList)).

start_children([]) ->
    [];
start_children([{M, F, A, T} | ChildSpecList]) ->
    case (catch apply(M, F, A)) of
        {ok, Pid} ->
            [{Pid, {M, F, A, T}} | start_children(ChildSpecList)];
        _ ->
            start_children(ChildSpecList)
    end.

restart_child(Pid, ChildList, Reason) ->
    {value, {Pid, {M, F, A, T}}} = lists:keysearch(Pid, 1, ChildList),
    if
        T == permanent orelse T == transient andalso Reason /= normal ->
            {ok, NewPid} = apply(M, F, A),
            [{NewPid, {M, F, A, T}} | lists:keydelete(Pid, 1, ChildList)];
        true ->
            ChildList
    end.

loop(ChildList) ->
    receive
        {'EXIT', Pid, Reason} ->
            NewChildList = restart_child(Pid, ChildList, Reason),
            loop(NewChildList);
        {stop, From} ->
            From ! {reply, terminate(ChildList)}
    end.

stop(Name) ->
    Name ! {stop, self()},
    receive
        {reply, Reply} -> Reply
    end.

terminate([{Pid, _} | ChildList]) ->
    exit(Pid, kill),
    terminate(ChildList);
terminate(_ChildList) ->
ok.

update_restarts(R, T) ->
    {MegS, S, _} = now(),
    Now = MegS * 1000 * 1000 + S,
    [Now | lists:filter(fun (E) -> (Now - T) < E end, R)].

% exercise_6_3:start_link(s1, [{add_one, start, [], transient}]).
% exercise_6_3:start_link(s1, [{add_one, start, [], permanent}]).