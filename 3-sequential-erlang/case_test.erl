-module(case_test).

-export([case_unsafe/1]).
-export([case_safe/1]).
-export([case_preferred/1]).

case_unsafe(X) ->
    case X of
        one -> Y = true;
        _   -> Z = two
    end.

case_safe(X) ->
    case X of
        one -> Y = 12;
        _   -> Y = 196
    end,
    X + Y.

case_preferred(X) ->
    Y = case X of
        one -> 12;
        _   -> 196
    end,
    X + Y.
