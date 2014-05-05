-module(exercise_7_3).

-export([new/0]).
-export([destroy/1]).
-export([write/3]).
-export([delete/2]).
-export([read/2]).
-export([match/2]).

-include("exercise_7_3.hrl").

% returns Db
new() -> [].

% returns ok
destroy(_Db) -> ok.

% returns NewDb
write(Key, Element, Db) -> [#data{key = Key, data = Element} | Db].

% returns NewDb
delete(Key, Db) -> [X || X <- Db, X#data.key /= Key].

% returns {ok, Element} | {error, instance}
read(Key, Db) ->
    case R = [X || X <- Db, X#data.key == Key] of
        [] -> {error, instance};
        _ -> R
    end.

% returns [Key1, ..., Keyn]
match(Element, Db) ->
    lists:filtermap(fun(Elem) ->
        case Elem#data.data == Element of
            true -> {true, Elem#data.key};
            false -> false
        end
    end, Db).
