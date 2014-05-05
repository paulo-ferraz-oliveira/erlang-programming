-module(even).

-export([list/1]).

list([]) -> [];
list([H|T]) when H rem 2 == 0 -> [H | list(T)];
list([_|T]) -> list(T).