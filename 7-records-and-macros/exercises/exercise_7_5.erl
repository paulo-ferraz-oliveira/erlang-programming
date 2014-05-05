-module(exercise_7_5).

-export([tree/3]).
-export([sum/1]).
-export([imax/1]).
-export([imin/1]).
-export([ordered/1]).
-export([insert/2]).

-include("exercise_7_5.hrl").

%-define(IS_LEAF(X), X#bt.l == undefined andalso X#bt.r == undefined).

tree(H) when is_integer(H) ->
    #bt{h = H, l = undefined, r = undefined};
tree(H) ->
    H.

tree(H, L, R) ->
    #bt{h = H, l = tree(L), r = tree(R)}.

sum(undefined) ->
    0;
sum(Binary_tree) ->
    Binary_tree#bt.h + sum(Binary_tree#bt.l) + sum(Binary_tree#bt.r).

imax(Binary_tree) ->
    imax(Binary_tree#bt.l, Binary_tree#bt.r, Binary_tree#bt.h).

imax(Left_node, Right_node, Head) ->
    if
        Left_node == undefined andalso Right_node == undefined ->
            Head;
        Right_node == undefined ->
            max(imax(Left_node), Head);
        Left_node == undefined ->
            max(imax(Right_node), Head);
        true ->
            max(max(imax(Left_node), imax(Right_node)), Head)
    end.

imin(Binary_tree) ->
    imin(Binary_tree#bt.l, Binary_tree#bt.r, Binary_tree#bt.h).

imin(Left_node, Right_node, Head) ->
    if
        Left_node == undefined andalso Right_node == undefined ->
            Head;
        Right_node == undefined ->
            min(imin(Left_node), Head);
        Left_node == undefined ->
            min(imin(Right_node), Head);
        true ->
            min(min(imin(Left_node), imin(Right_node)), Head)
    end.

ordered(Node) ->
    ordered(Node, -20, 20).

ordered(undefined, _, _) ->
    true;
ordered(Node, Min, Max) ->
    OrdLeft = ordered(Node#bt.l, Min, Node#bt.h),
    OrdRight = ordered(Node#bt.r, Node#bt.h, Max),
    if
        Node#bt.h >= Min andalso Node#bt.h =< Max andalso OrdLeft andalso OrdRight -> true;
        true -> false
    end.

insert(Value, undefined) ->
    tree(Value);
insert(Value, Binary_tree) ->
    if
        Value == Binary_tree#bt.h andalso Binary_tree#bt.r == undefined ->
            tree(Binary_tree#bt.h, Binary_tree#bt.l, Value);
        Value =< Binary_tree#bt.h ->
            tree(Binary_tree#bt.h, insert(Value, Binary_tree#bt.l), Binary_tree#bt.r);
        true ->
            tree(Binary_tree#bt.h, Binary_tree#bt.l, insert(Value, Binary_tree#bt.r))
    end.

% exercise_7_5:ordered(exercise_7_5:tree(4, exercise_7_5:tree(2, 1, 3), 5)).