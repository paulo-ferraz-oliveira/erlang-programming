-module(list_map).

-export([m/2]).

m(_F, []) ->
    [];
m(F, [H | T]) ->
    [F(H) | m(F, T)].

