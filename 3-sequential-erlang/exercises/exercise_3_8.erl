-module(exercise_3_8).

-export([tokenize/1]).

tokenize([]) -> [];
tokenize([$( | Rest]) -> [lparen | tokenize(Rest)];
tokenize([$) | Rest]) -> [rparen | tokenize(Rest)];
tokenize([Op | Rest]) when (Op =:= $+) or (Op =:= $-) -> [op(Op) | tokenize(Rest)];
tokenize([Digit | Rest]) when is_integer(Digit) -> [digit(Digit) | tokenize(Rest)];
tokenize([O | Rest]) -> io:format("unable to parse unknown ~p~n", [O]), tokenize(Rest).

op($+) -> {op, plus};
op($-) -> {op, minus}.

digit(Digit) -> {num, Digit - 48}.

% To Be Continued...