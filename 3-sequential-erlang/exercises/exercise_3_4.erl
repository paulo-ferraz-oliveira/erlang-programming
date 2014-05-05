-module(exercise_3_4).

-export([new/0]).
-export([destroy/1]).
-export([write/3]).
-export([delete/2]).
-export([read/2]).
-export([match/2]).

% returns Db
new() -> [].

% returns ok
destroy(_Db) -> ok.

% returns NewDb
write(Key, Element, Db) -> [{Key, Element} | Db].

% returns NewDb
delete(Key, Db) -> delete(Key, Db, []).

delete(_Key, [], NewDb) -> NewDb;
delete(Key, [DbH | DbT], NewDb) when Key == element(1, DbH) -> NewDb ++ DbT;
delete(Key, [DbH | DbT], NewDb) -> delete(Key, DbT, NewDb ++ [DbH]).

% returns {ok, Element} | {error, instance}
read(_Key, []) -> {error, instance};
read(Key, [DbH | _DbT]) when Key == element(1, DbH) -> {ok, element(2, DbH)};
read(Key, [_DbH | DbT]) -> read(Key, DbT).

% returns [Key1, ..., Keyn]
match(Element, Db) -> match(Element, Db, []).

match(_Element, [], Values) -> Values;
match(Element, [DbH | DbT], Values) when Element == element(2, DbH) -> match(Element, DbT, Values ++ [element(1, DbH)]);
match(Element, [_DbH | DbT], Values) -> match(Element, DbT, Values).
