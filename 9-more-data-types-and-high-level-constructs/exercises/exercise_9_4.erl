-module(exercise_9_4).

-export([all/2]).
-export([any/2]).
-export([dropwhile/2]).
-export([filter/2]).
-export([filtermap/2]).
-export([flatmap/2]).
-export([foldl/3]).
-export([foldr/3]).
-export([foreach/2]).
-export([keymap/3]).
-export([map/2]).
-export([mapfoldl/3]).
-export([mapfoldr/3]).
-export([merge/3]).
-export([partition/2]).
%%-export([sort/2]).
-export([splitwith/2]).
-export([takewhile/2]).
-export([umerge/3]).
%-export([usort/2]).
-export([zipwith/3]).
-export([zipwith3/4]).

all(Pred, [Hd | Tail]) ->
    case Pred(Hd) of
        true -> all(Pred, Tail);
        false -> false
    end;
all(Pred, []) when is_function(Pred, 1) ->
    true.

any(Pred, [Hd | Tail]) ->
    case Pred(Hd) of
        true -> true;
        false -> any(Pred, Tail)
    end;
any(Pred, []) when is_function(Pred, 1) ->
    false.

dropwhile(Pred, [Hd | Tail] = Rest) ->
    case Pred(Hd) of
        true -> dropwhile(Pred, Tail);
        false -> Rest
    end;
dropwhile(Pred, []) when is_function(Pred, 1) ->
    [].

filter(Pred, [Hd | Tail]) ->
    case Pred(Hd) of
        true -> [Hd | filter(Pred, Tail)];
        false -> filter(Pred, Tail)
    end;
filter(Pred, []) when is_function(Pred, 1) ->
    [].
%... or we could use list comprehensions

filtermap(Fun, [Hd | Tail]) ->
    case Fun(Hd) of
        {true, Value} -> [Value | filtermap(Fun, Tail)];
        true -> [Hd, filtermap(Fun, Tail)];
        _ -> filtermap(Fun, Tail)
    end;
filtermap(Fun, []) when is_function(Fun) ->
    [].

flatmap(Fun, [Hd | Tail]) ->
    Fun(Hd) ++ flatmap(Fun, Tail);
flatmap(Fun, []) when is_function(Fun, 1) ->
    [].

foldl(Fun, Acc, [Hd | Tail]) ->
    foldl(Fun, Fun(Hd, Acc), Tail);
foldl(Fun, Acc, []) when is_function(Fun, 2) ->
    Acc.

foldr(Fun, Acc, [Hd | Tail]) ->
    Fun(Hd, foldr(Fun, Acc, Tail));
foldr(Fun, Acc, []) when is_function(Fun, 2) ->
    Acc.

foreach(Fun, [Hd | Tail]) ->
    Fun(Hd),
    foreach(Fun, Tail);
foreach(Fun, []) when is_function(Fun, 1) ->
    ok.

keymap(Fun, N, [Hd | Tail]) ->
    [setelement(N, Hd, Fun(element(N, Hd))) | keymap(Fun, N, Tail)];
keymap(Fun, N, []) when is_function(Fun) andalso is_integer(N) andalso N >= 1 ->
    [].

map(Fun, [Hd | Tail]) ->
    [Fun(Hd) | map(Fun, Tail)];
map(Fun, []) when is_function(Fun, 1) ->
    [].

mapfoldl(Fun, Acc, [Hd | Tail]) ->
    {MHd, Acc1} = Fun(Hd, Acc),
    {MTail, Acc2} = mapfoldl(Fun, Acc1, Tail),
    {[MHd | MTail], Acc2};
mapfoldl(Fun, Acc, []) when is_function(Fun, 2) ->
    {[], Acc}.

mapfoldr(Fun, Acc, [Hd | Tail]) ->
    {MTail, Acc1} = mapfoldr(Fun, Acc, Tail),
    {MHd, Acc2} = Fun(Hd, Acc1),
    {[MHd | MTail], Acc2};
mapfoldr(Fun, Accu, []) when is_function(Fun, 2) ->
    {[], Accu}.

merge(Fun, List1, List2) ->
    SList1 = lists:sort(Fun, List1),
    SList2 = lists:sort(Fun, List2),
    merge_(Fun, SList1, SList2).

merge_(Fun, [Hd1 | Tail1], [Hd2 | Tail2]) ->
    case Fun(Hd1, Hd2) of
        true -> [Hd1, Hd2 | merge_(Fun, Tail1, Tail2)]; % Hd1 =< Hd2
        false -> [Hd2, Hd1 | merge_(Fun, Tail1, Tail2)] % Hd1  > Hd2
    end;
merge_(Fun, [], List2) when is_function(Fun, 2) ->
    List2;
merge_(Fun, List1, []) when is_function(Fun, 2) ->
    List1.

partition(Pred, [Hd | Tail]) ->
    {Satisfying, NotSatisfying} = partition(Pred, Tail),
    case Pred(Hd) of
        true -> {[Hd | Satisfying], NotSatisfying};
        false -> {Satisfying, [Hd | NotSatisfying]}
    end;
partition(Pred, []) when is_function(Pred, 1) ->
    {[], []}.

% sort: too "complex" to implement at this moment!

splitwith(Pred, List) ->
    splitwith(Pred, List, []).

splitwith(Pred, [Hd | Tail], Taken) ->
    case Pred(Hd) of
        true -> splitwith(Pred, Tail, Taken ++ [Hd]);
        false -> {Taken, [Hd | Tail]}
    end;
splitwith(Pred, [], Taken) when is_function(Pred, 1) ->
    {Taken, []}.

takewhile(Pred, [Hd | Tail]) ->
    case Pred(Hd) of
        true -> [Hd | takewhile(Pred, Tail)];
        false -> []
    end;
takewhile(Fun, []) when is_function(Fun) ->
    [].

umerge(Fun, List1, List2) ->
    SList1 = lists:usort(Fun, List1),
    SList2 = lists:usort(Fun, List2),
    umerge_(Fun, SList1, SList2).

umerge_(Fun, [Hd1 | Tail1], [Hd2 | Tail2]) ->
    case Fun(Hd1, Hd2) of
        true -> [Hd1, Hd2 | umerge_(Fun, Tail1, Tail2)]; % Hd1 =< Hd2
        false -> [Hd2, Hd1 | umerge_(Fun, Tail1, Tail2)] % Hd1  > Hd2
    end;
umerge_(Fun, [], List2) when is_function(Fun, 2) ->
    List2;
umerge_(Fun, List1, []) when is_function(Fun, 2) ->
    List1.

% usort: too "complex" to implement at this moment!

zipwith(Combine, [Hd1 | Tail1] = List1, [Hd2 | Tail2] = List2) when length(List1) == length(List2) ->
    [Combine(Hd1, Hd2), zipwith(Combine, Tail1, Tail2)];
zipwith(Combine, [], []) when is_function(Combine, 2) ->
    [].

zipwith3(Combine, [Hd1 | Tail1] = List1, [Hd2 | Tail2] = List2, [Hd3 | Tail3] = List3) when length(List1) == length(List2) andalso length(List2) == length(List3) ->
    [Combine(Hd1, Hd2, Hd3), zipwith3(Combine, Tail1, Tail2, Tail3)];
zipwith3(Combine, [], [], []) when is_function(Combine, 3) ->
    [].
