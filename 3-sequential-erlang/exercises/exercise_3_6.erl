-module(exercise_3_6).

-export([quicksort/1]).
-export([mergesort/1]).

quicksort([]) ->
    [];
quicksort([Pivot | Rest]) ->
    quicksort([L || L <- Rest, L < Pivot]) ++ [Pivot] ++ quicksort([R || R <- Rest, R >= Pivot]).

mergesort(L) ->
    {L1B, L2B} = lists:split(length(L) div 2, L),
    L1 = quicksort(L1B),
    L2 = quicksort(L2B),
    merge(L1, L2).

merge(L1, []) -> L1;
merge([], L2) -> L2;
merge([H1 | T1], [H2 | T2]) when H1 =< H2 -> [H1 | merge(T1, [H2 | T2])];
merge([H1 | T1], [H2 | T2]) -> [H2 | merge([H1 | T1], T2)].