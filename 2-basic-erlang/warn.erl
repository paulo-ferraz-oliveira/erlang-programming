-module(warn).

-export([me/0]).

-author({"Paulo Oliveira"}).

me() ->
    process_flag(trap_exit, true),
    spawn_link(fun () -> Var = 2, Double = 2 * four end),
    receive
        { 'EXIT', Pid, Msg } -> io:format("Error from process ~w: ~w~n", [ Pid, Msg ])
    end.