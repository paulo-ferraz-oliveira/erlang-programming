-module(exercise_5_5).

-export([start/0, stop/0, init/0]).
-export([incoming/1, outgoing/1]).
-export([off_hook/0, on_hook/0]).
-export([other_off_hook/1, other_on_hook/1]).

start() ->
    ringer_fsm:start(),
    register(phone_fsm, spawn(?MODULE, init, [])).

stop() ->
    phone_fsm ! {stop, self()},
    receive
        ok -> ok
    end,
    ringer_fsm:stop(),
    ok.

init() -> idle().

incoming(Number) -> phone_fsm ! {incoming, Number}, ok.
outgoing(Number) -> phone_fsm ! {outgoing, Number}, ok.
off_hook() -> phone_fsm ! off_hook, ok.
on_hook() -> phone_fsm ! on_hook, ok.
other_off_hook(Number) -> phone_fsm ! {other_off_hook, Number}, ok.
other_on_hook(Number) -> phone_fsm ! {other_on_hook, Number}, ok.

idle() ->
    receive
        {incoming, Number} ->
            ringer_fsm:start_ringing(),
            ringing(Number);
        off_hook ->
            ringer_fsm:start_tone(),
            dial();
        {stop, Pid} ->
            Pid ! ok
    end.

ringing(Number) ->
    receive
        {other_on_hook, Number} ->
            ringer_fsm:stop_ringing(),
            idle();
        {Number, off_hook} ->
            ringer_fsm:stop_ringing(),
            connected(Number)
    end.

dial() ->
    receive
        on_hook ->
            ringer_fsm:stop_tone(),
            idle();
        {outgoing, Number} ->
            ringer_fsm:stop_tone(),
            waiting(Number)
    end.

waiting(Number) ->
    receive
        {other_off_hook, Number} ->
            connected(Number);
        on_hook ->
            idle()
    end.

connected(Number) ->
    receive
        on_hook ->
            idle();
        {other_on_hook, Number} ->
            ringer_fsm:start_tone(),
            disconnected()
    end.

disconnected() ->
    receive
        on_hook ->
            ringer_fsm:stop_tone(),
            idle()
    end.
