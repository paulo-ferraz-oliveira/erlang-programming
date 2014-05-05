-module(index).

-export([idx/2]).

idx(0, [X | _]) -> X;
idx(N, [_ | Xs]) when N > 0 -> idx(N - 1, Xs).