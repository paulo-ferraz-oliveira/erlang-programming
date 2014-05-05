-module(my_db).
-vsn(1.0).

-export([start/0, stop/0]).
-export([write/2, read/1, delete/1]).
-export([init/0, loop/1]).
-export([dump/0]).
-export([code_upgrade/0]).

start() ->
    register(db_server, spawn(db_server, init, [])).

stop() ->
    db_server ! stop.

code_upgrade() ->
    db_server ! code_upgrade.

dump() ->
    db_server ! {dump_db, self()},
    receive
        Reply -> Reply
    end.

write(Key, Data) ->
    db_server ! {write, Key, Data}.

read(Key) ->
    db_server ! {read, self(), Key},
    receive
        Reply -> Reply
    end.

delete(Key) ->
    db_server ! {delete, Key}.

init() ->
    loop(db:new()).

loop(Db) ->
    receive
        {write, Key, Data} ->
            loop(exercise_8_1:write(Key, Data, Db));
        {read, Pid, Key} ->
            Pid ! exercise_8_1:read(Key, Db),
            loop(Db);
        {delete, Key} ->
            loop(exercise_8_1:delete(Key, Db));
        code_upgrade ->
            code:load_file(exercise_8_1),
            code:soft_purge(exercise_8_1),
            loop(exercise_8_1:code_upgrade(Db));
        {dump_db, Pid} ->
            Pid ! Db,
            loop(Db);
        stop ->
            exercise_8_1:destroy(Db)
    end.