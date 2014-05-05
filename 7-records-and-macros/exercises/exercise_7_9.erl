-module(exercise_7_9).

-export([new/0]).
-export([destroy/1]).
-export([write/3]).
-export([delete/2]).
-export([read/2]).
-export([match/2]).

-ifdef(debug).
-define(DEBUG(Action, Data), io:format("Requested ~p with arguments ~p~n", [Action, Data])).
-else.
-define(DEBUG(Action, Data), ok).
-endif.

% returns Db
new() ->
    ?DEBUG(new, []),
    [].

% returns ok
destroy(_Db) ->
    ?DEBUG(destroy, _Db),
    ok.

% returns NewDb
write(Key, Element, Db) ->
    ?DEBUG(write, [Key, Element, Db]),
    [{Key, Element} | Db].

% returns NewDb
delete(Key, Db) ->
    ?DEBUG(delete, [Key, Db]),
    lists:keydelete(Key, 1, Db).

% returns {ok, Element} | {error, instance}
read(Key, Db) ->
    ?DEBUG(read, [Key, Db]),
    case lists:keyfind(Key, 1, Db) of
        false -> {error, instance};
        {Key, Value} -> {ok, Value}
    end.

% returns [Key1, ..., Keyn]
match(Element, Db) ->
    ?DEBUG(match, [Element, Db]),
    lists:filtermap(fun(Elem) ->
        case element(2, Elem) == Element of
            true -> {true, element(1, Elem)};
            false -> false
        end
    end, Db).
