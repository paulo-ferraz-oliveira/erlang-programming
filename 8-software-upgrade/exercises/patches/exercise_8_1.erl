-module(exercise_8_1).
-vsn(2.1).

-export([new/0, destroy/1]).
-export([write/3, read/2, delete/2]).
-export([code_upgrade/1]).

code_upgrade(List) ->
    code_upgrade(List, new()).

code_upgrade([], Db) ->
    Db;
code_upgrade([{Key, Data} | T], Db) ->
    code_upgrade(T, gb_trees:insert(Key, Data, Db)).

new() ->
    gb_trees:empty().

write(Key, Data, Db) ->
    gb_trees:insert(Key, Data, Db).

read(Key, Db) ->
    case gb_trees:lookup(Key, Db) of
        none -> {error, instance};
        {value, Data} -> {ok, Data}
    end.

destroy(_Db) ->
    ok.

delete(Key, Db) ->
    gb_trees:delete(Key, Db).
