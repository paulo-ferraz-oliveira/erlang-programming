-module(exercise_5_4).

-export([init/1, terminate/1, handle_event/2]).

init(_) ->
    [].

terminate(Stats) ->
    Stats.

handle_event({Type, _, Description}, Stats) ->
    case lists:keyfind({Type, Description}, 1, Stats) of
        {Key, Num} -> lists:keyreplace(Key, 1, Stats, {Key, Num + 1});
        false -> [{{Type,Description},1} | Stats]
    end;
handle_event(_Event, Stats) ->
    Stats.
