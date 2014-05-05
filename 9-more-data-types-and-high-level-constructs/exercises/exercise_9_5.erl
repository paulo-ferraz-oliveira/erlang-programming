-module(exercise_9_5).

-export([investigate/0]).

investigate() ->
    io:format("<<42:6>> in binary is 101010, i.e., number 42~n"),
    io:format("<<42:5>> in binary is  01010, i.e., number 10~n"),
    % <<42:6>> = 1010 10
    %            X=10 Y=2
    <<X:4, Y:2>> = <<42:6>>,
    io:format("X = ~p, Y = ~p~n", [X, Y]).

% <<C:4,D:4>> = <<1998:6>> is not possible (not enough bits).
% the same goes for <<C:4,D:2>> = <<1998:8>>.

% 1998:20 = 0110 0111 0000 0110 1110
% 1998:8  =                0110 1110
% C:4,D:2 =                 C=11? D=2? wrong!