-module(exercise_3_2).

-export([create/1]).
-export([reverse_create/1]).

create(X) when X < 0 -> [];
create(X) -> create(X, []).

create(X, L) when length(L) < X -> create(X, L ++ [length(L) + 1]);
create(_, L) -> L.

reverse_create(L) -> lists:reverse(create(L)).