-module(exercise_9_2).

-export([div3/0]).
-export([sqint/1]).
-export([inters/2]).
-export([symmdiff/2]).

% Using list comprehensions, create a set of integers between 1 and 10 that are
% divisible by three (e.g., [3,6,9]).

div3() ->
    [R || R <- lists:seq(1, 10), R rem 3 == 0].

% Using list comprehensions, remove all non-integers from a polymorphic list.
% Return the list of integers squared: [1,hello, 100, boo, “boo”, 9] should
% return [1, 10000, 81].

sqint(L) ->
    [math:pow(R, 2) || R <- L, is_integer(R)].

% Using list comprehensions and given two lists, return a new list that is the
% intersection of the two lists (e.g., [1,2,3,4,5] and [4,5,6,7,8] should
% return [4,5]).

inters(L1, L2) ->
    [X || X <- L1, lists:member(X, L2)].

% Using list comprehensions and given two lists, return a new list that is the
% symmetric difference of the two lists. Using [1,2,3,4,5] and [4,5,6,7,8]
% should return [1,2,3,6,7,8].

symmdiff(L1, L2) ->
    [X || X <- L1, not(lists:member(X, L2))]
        ++ [X || X <- L2, not(lists:member(X, L1))].