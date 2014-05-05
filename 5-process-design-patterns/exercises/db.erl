-module(db).

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
delete(Key, Db) -> lists:keydelete(Key, 1, Db).

% returns {ok, Element} | {error, instance}
read(Key, Db) ->
    case lists:keyfind(Key, 1, Db) of
        false -> {error, instance};
        {Key, Value} -> {ok, Value}
    end.

% returns [Key1, ..., Keyn]
match(Element, Db) ->
    lists:filtermap(fun(Elem) ->
        case element(2, Elem) == Element of
            true -> {true, element(1, Elem)};
            false -> false
        end
    end, Db).
