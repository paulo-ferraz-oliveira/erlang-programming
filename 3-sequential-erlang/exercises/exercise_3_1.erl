-module(exercise_3_1).

-export([sum/1, sum/2]).

sum(0) -> 0;
sum(N) -> N + sum(N - 1).

sum(N, M) when N == M -> M;
sum(N, M) when N < M -> M + sum(N, M - 1);
sum(_, _) -> throw(n_bigger_than_m).