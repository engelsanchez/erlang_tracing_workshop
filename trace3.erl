-module(trace3).
-export([start/0]).

start() ->
    register(?MODULE, self()),
    io:format("~p started\n", [?MODULE]),
    receive
        {msg2, P} ->
            P ! msg2_reply
    end.
