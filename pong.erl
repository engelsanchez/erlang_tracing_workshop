-module(pong).
-export([loop/0]).


loop() ->
    receive
        ping ->
            timer:sleep(1000),
            ping ! pong,
            loop();
        stop ->
            ok
    end.

