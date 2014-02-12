-module(ping).
-export([start_loop/0, start/0]).


start() ->
    PongPid = spawn(fun pong:loop/0),
    register(pong, PongPid),
    spawn(fun start_loop/0).

start_loop() ->
    register(ping, self()),
    pong ! ping,
    loop().

loop() ->
    receive
        pong ->
            timer:sleep(1000),
            pong ! ping,
            loop();
        stop ->
            pong ! stop,
            ok
    end.
