-module(exercise_4_1).

-export([start/0]).
-export([stop/0]).
-export([print/1]).
-export([loop/0]).

start() ->
    register(exercise_4_1, spawn(exercise_4_1, loop, [])),
    ok.

stop() ->
    exercise_4_1 ! stop,
    ok.

print(Term) ->
    exercise_4_1 ! {print, Term},
    ok.

loop() ->
    receive
        stop ->
            stop;
        {print, Term} ->
            io:format("~p~n", [Term]),
            loop()
    end.