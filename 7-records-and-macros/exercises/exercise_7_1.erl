-module(exercise_7_1).

-export([test1/0, test2/0]).

birthday({Name, Age, Phone, Address}) -> % MODIFIED
    {Name, Age + 1, Phone, Address}. % MODIFIED

joe() ->
    {"Joe", 21, "999-999", "41 rue Duplaa"}. % MODIFIED

showPerson({Name, Age, Phone, Address}) -> % MODIFIED
    io:format("name: ~p age: ~p phone: ~p address: ~p~n", [Name, Age, Phone, Address]). % MODIFIED

test1() ->
    showPerson(joe()).

test2() ->
    showPerson(birthday(joe())).