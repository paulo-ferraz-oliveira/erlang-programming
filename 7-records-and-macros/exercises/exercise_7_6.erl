-module(exercise_7_6).

-export([e/1]).

%-define(show,true).

-ifndef(show).
-define(SHOW_EVAL(X), io:format("~p = ~p~n", [??X, X])).
-else.
-define(SHOW_EVAL(X), X).
-endif.

e(V) ->
    ?SHOW_EVAL(io:format("Side effect: ~p~n", [V])).