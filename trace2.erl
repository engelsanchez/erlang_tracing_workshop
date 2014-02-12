-module(trace2).
-export([start/0]).

start() ->
    register(?MODULE, self()),
    io:format("~p started\n", [?MODULE]),
    receive
        {msg1, P1} ->
            trace3 ! {msg2, self()},
            receive
                msg2_reply ->
                    P1 ! msg1_reply
            end
    end.

            

