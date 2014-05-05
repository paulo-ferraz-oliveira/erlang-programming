-module(exercise_7_7).

-export([test/0]).

-define(COUNT(Func), io:format("~p:~p called~n", [?MODULE, Func])).

test() ->
    ?COUNT(test).