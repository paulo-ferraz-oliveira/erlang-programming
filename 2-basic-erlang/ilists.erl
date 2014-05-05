-module(ilists).

-export([list_max/1]).
-export([list_reverse/1]).
-export([list_split/2]).
-export([list_split_in_half/1]).
-export([list_sum/1]).
-export([list_sum2/1]).
-export([list_bubble_sort/1]).

%%%%%%%%%%%
% MAX
%%%%%%%%%%%
list_max([H|T]) -> {ok, list_max(H, T)}.

list_max(X, []) -> X;
list_max(X, [H|T]) when X < H -> list_max(H, T);
list_max(X, [_|T]) -> list_max(X, T).

%%%%%%%%%%%
% REVERSE
%%%%%%%%%%%
list_reverse(L) -> {ok, list_reverse(L,[])}.

list_reverse([], Rev) -> Rev;
list_reverse([H|T], RevRes) -> list_reverse(T, [H] ++ RevRes).

%%%%%%%%%%%
% SPLIT
%%%%%%%%%%%
list_split(Pos, L) -> {ok, list_split(Pos, L, [])}.

list_split(Pos, [H|T], Sp) when length(Sp) < Pos -> list_split(Pos, T, Sp ++ [H]);
list_split(_, L, Sp) -> {Sp, L}.

list_split_in_half(L) -> list_split(length(L) / 2, L).

%%%%%%%%%%%
% SUM
%%%%%%%%%%%
% Tail-recursive version.
list_sum(L) ->
    Now = now(),
    Res = list_sum(L, 0),
    {ok, {time, timer:now_diff(now(), Now)}, {res, Res}}.

list_sum([], Acc) -> Acc;
list_sum([H|T], Acc) -> list_sum(T, H + Acc).

% Non-tail-recursive version.
list_sum2(L) ->
    Now = now(),
    Res = list_sum2(L, i),
    {ok, {time, timer:now_diff(now(), Now)}, {res, Res}}.

list_sum2([], i) -> 0;
list_sum2([H|T], i) -> H + list_sum2(T, i).

%%%%%%%%%%%
% BUBBLE
%%%%%%%%%%%
list_bubble_sort(L) -> list_bubble_sort(L, [], false).

list_bubble_sort([A, B | T], Acc, _) when A > B -> list_bubble_sort([A | T], [B | Acc], true);
list_bubble_sort([A, B | T], Acc, Tainted) -> list_bubble_sort([B | T], [A | Acc], Tainted);
list_bubble_sort([A | T], Acc, Tainted) -> list_bubble_sort(T, [A | Acc], Tainted);
list_bubble_sort([], Acc, true) -> list_bubble_sort(lists:reverse(Acc));
list_bubble_sort([], Acc, false) -> lists:reverse(Acc).

