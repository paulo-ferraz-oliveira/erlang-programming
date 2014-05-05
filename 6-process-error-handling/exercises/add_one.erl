-module(add_one).

-export([start/0, request/1, loop/0, stop/1]).

start() ->
    Pid = spawn_link(add_one, loop, []),
    register(add_one, Pid),
    {ok, Pid}.

stop(normal) -> add_one ! normal;
stop(abnormal) -> add_one ! abnormal.

request(Int) ->
    add_one ! {request, self(), Int},
    receive
        {result, Result} -> Result
        after 1000 -> timeout
    end.

loop() ->
    receive
        {request, Pid, Msg} ->
            Pid ! {result, Msg + 1},
            loop();
        normal ->
            ok;
        abnormal ->
            exit(kill)
    end.