-module(pong).
-export([loop/0]).


loop() ->
    receive
        {ping, Msg} ->
            timer:sleep(1000),
            ping ! {pong, Msg},
            loop();
        stop ->
            ok
    end.

