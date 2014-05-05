-module(exercise_7_2).

-export([is_person/0]).
-export([is_not_person/0]).
-export([foobar/1]).
-export([get_person/0]).

-record(person, {name, age, address}).

get_person() ->
    #person{name = "Paulo", age = 33, address = "41 rue Duplaa"}.

is_person() ->
    P = get_person(),
    is_record(P, person).

is_not_person() ->
    not(is_record(atom, person)).

foobar(P) when is_record(P, person) andalso P#person.name == "Paulo" ->
    true;
foobar(P) when is_record(P, person) andalso P#person.name /= "Paulo" ->
    false;
foobar(_) ->
    non_record.
