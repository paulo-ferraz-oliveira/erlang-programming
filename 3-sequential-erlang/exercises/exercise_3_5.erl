-module(exercise_3_5).

-export([filter/2]).
-export([reverse/1]).
-export([concatenate/1]).
-export([flatten/1]).

%% filter
filter(L, I) -> filter(L, I, []).

filter([], _, F) -> F;
filter([H | T], I, F) when H =< I -> filter(T, I, F ++ [H]);
filter([_ | T], I, F) -> filter(T, I, F).

%% reverse
reverse(L) -> reverse(L, []).

reverse([], R) -> R;
reverse([H | T], R) -> reverse(T, [H] ++ R).

%% concatenate
concatenate(LL) -> concatenate(LL, []).

concatenate([], R) -> R;
concatenate([H | T], R) -> concatenate(T, R ++ H).

%% flatten
flatten(LL) -> concatenate([iflatten(LL)], []).

iflatten([]) -> [];
iflatten(X) when not(is_list(X)) -> [X];
iflatten([H | T]) -> iflatten(H) ++ iflatten(T).
