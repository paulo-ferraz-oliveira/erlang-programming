-module(try_catch).

-export([t1/0]).
-export([t2/0]).
-export([t3/0]).
-export([t4/0]).
-export([t5/0]).
-export([t6/0]).
-export([t7/0]).
-export([t8/0]).
-export([t9/0]).

t1() ->
    X = 2,

    try (X = 3) of
        Val -> {normal, Val}
    catch
        _:_ -> 43
    end.

t2() ->
    X = 2,

    try (X = 3) of
        Val -> {normal, Val}
    catch
        error:_ -> 42
    end.

t3() ->
    X = 2,

    try (X = 3) of
        Val -> {normal, Val}
    catch
        error:Error -> {error, Error}
    end.

t4() ->
    X = 2,

    try (X = 3) of
        Val -> {normal, Val}
    catch
        error:{badmatch, V} -> {error, {batmatch, V}}
    end.

t5() ->
    A = try (throw(non_normal_return)) of
        Val -> {normal, Val}
    catch
        _:_ -> error_h
    end,

    io:format("~p~n", [A]).

t6() ->
    try (throw(non_normal_return)) of
        Val -> {normal, Val}
    catch
        _:_ -> error_h
    end.

t7() ->
    try (throw(non_normal_return)) of
        Val -> {normal, Val}
    catch
        throw:_ -> throw_caught
    end.

t8() ->
    {'EXIT', {badarith, 3}}.

t9() ->
    throw({'EXIT', {badarith, 3}}).
