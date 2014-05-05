-module(exercise_9_1).

-export([seq/1]).
-export([smaller/2]).
-export([even/1]).
-export([concat_lists/1]).
-export([sum_int_list/1]).

% Using funs and higher-order functions, write a function that prints out the integers between 1 and N.

seq(N) ->
    lists:map(fun(E) -> io:format("~p~n", [E]) end, lists:seq(1, N)).

% Using funs and higher-order functions, write a function that, given a list of integers and
% an integer, will return all integers smaller than or equal to that integer.

smaller(Int_list, Max_int) ->
    lists:filter(fun(E) ->
        E < Max_int
    end, Int_list).

% Using funs and higher-order functions, write a function that prints out the even integers between 1 and N.

even(N) ->
    lists:map(fun(E) ->
        io:format("~p~n", [E])
    end, lists:filter(fun(E) ->
        E rem 2 == 0
    end, lists:seq(1, N))).

% Using funs and higher-order functions, write a function that, given a list of lists, will concatenate them.

concat_lists(List) ->
    lists:foldl(fun(Head_list, Acc) -> Acc ++ Head_list end, [], List).

% Using funs and higher-order functions, write a function that, given a list of integers, returns the sum of the integers.

sum_int_list(List) ->
    lists:foldl(fun(Int, Acc) -> Acc + Int end, 0, List).
