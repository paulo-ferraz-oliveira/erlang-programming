-module(exercise_6_1).

-export([start/0]).
-export([stop/0]).
-export([print/1]).
-export([ping/0]).
-export([loop/0]).

start() ->
    register(exercise_6_1, spawn_link(exercise_6_1, loop, [])),
    ok.

stop() ->
    exercise_6_1 ! stop,
    ok.

print(Term) ->
    exercise_6_1 ! {print, Term},
    ok.

ping() ->
    exercise_6_1 ! ping,
    ok.

loop() ->
    receive
        stop ->
            exit({stop, stopped});
        ping ->
            io:format("pong~n"),
            loop();
        {print, Term} ->
            io:format("~p~n", [Term]),
            loop()
    end.