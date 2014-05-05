-module(exercise_9_3).

-export([zip/2]).
-export([zipWith/3]).

zip(_L1, []) ->
    [];
zip([], _L2) ->
    [];
zip([HL1 | TL1], [HL2 | TL2]) ->
    [{HL1, HL2} | zip(TL1, TL2)].

zipWith(_Fun, _L1, []) ->
    [];
zipWith(_Fun, [], _L2) ->
    [];
zipWith(Fun, [HL1 | TL1], [HL2 | TL2]) ->
    [Fun(HL1, HL2) | zipWith(Fun, TL1, TL2)].
