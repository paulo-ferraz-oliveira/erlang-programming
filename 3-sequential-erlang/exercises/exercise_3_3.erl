-module(exercise_3_3).

-export([print/1]).
-export([print_even/1]).

print(N) -> print(1, N).

print(N, X) when N > X -> done;
print(N, X) -> io:format("Number:~p~n",[N]), print(N + 1, X).

print_even(N) -> print_even(1, N).

print_even(N, X) when N > X -> done;
print_even(N, X) when N rem 2 == 0 -> io:format("Number:~p~n",[N]), print_even(N + 1, X);
print_even(N, X) -> print_even(N + 1, X).