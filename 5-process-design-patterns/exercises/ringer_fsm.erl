-module (ringer_fsm).

-export ([start/0, stop/0, init/0]).
-export ([start_ringing/0, stop_ringing/0]).
-export ([start_tone/0, stop_tone/0]).

start() ->
    register(ringer_fsm, spawn(?MODULE, init, [])),
    ok.

stop() ->
    ringer_fsm ! {stop, self()},
    receive ok -> ok end.

init() -> silent().

start_ringing() -> ringer_fsm ! ringer_on.
stop_ringing()  -> ringer_fsm ! ringer_off.
start_tone()    -> ringer_fsm ! dial_tone_on.
stop_tone()     -> ringer_fsm ! dial_tone_off.

silent() ->
    receive
        ringer_on ->
            ringing();
        dial_tone_on ->
            dial_tone();
        {stop, Pid} ->
            Pid ! ok
    end.

ringing() ->
    receive
        ringer_off ->
            silent()
    after
        1000 ->
            io:format("ringing~n"),
            ringing()
    end.

dial_tone() ->
    receive
        dial_tone_off ->
            silent()
    after
        1000 ->
            io:format("dial tone~n"),
            dial_tone()
    end.