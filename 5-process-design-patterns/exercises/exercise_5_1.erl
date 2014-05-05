-module(exercise_5_1).

-export([start/0]).
-export([stop/0]).
-export([write/2]).
-export([delete/1]).
-export([read/1]).
-export([match/1]).

-export([loop/1]).

% functional interface

start() -> register(db_server, spawn(?MODULE, loop, [db:new()])), ok.

stop() -> handle(stop).

write(Key, Element) -> handle(write, [Key, Element]).

delete(Key) -> handle(delete, [Key]).

read(Key) -> handle(read, [Key]).

match(Element) -> handle(match, [Element]).

% internal

handle(Action) ->
    handle(Action, []).

handle(Action, Data) ->
    case Data of
        [] -> db_server ! {self(), Action};
        _ -> db_server ! {self(), Action, Data}
    end,
    receive
        {reply, Reply} -> Reply
    end.

reply(Pid, Reply) ->
    Pid ! {reply, Reply}.

loop(Db) ->
    receive
        {Pid, stop} ->
            db:destroy(Db),
            unregister(db_server),
            Pid ! {reply, ok};
        {Pid, write, [Key, Element]} ->
            NewDb = db:write(Key, Element, Db),
            reply(Pid, ok),
            loop(NewDb);
        {Pid, delete, [Key]} ->
            NewDb = db:delete(Key, Db),
            reply(Pid, ok),
            loop(NewDb);
        {Pid, read, [Key]} ->
            reply(Pid, db:read(Key, Db)),
            loop(Db);
        {Pid, match, [Element]} ->
            reply(Pid, db:match(Element, Db)),
            loop(Db)
    end.
