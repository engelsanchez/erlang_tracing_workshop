-module(trace1).
-export([spawn_them/0, start/0]).
%-define(SET_TRACE, 1).

spawn_them() ->
    [spawn(M, start, []) || M <- [trace1, trace2, trace3]].

start() ->
    register(?MODULE, self()),
    io:format("~p started\n", [?MODULE]),
    receive
        start ->
            start_trace(),
            trace1 ! self_ping,
            trace2 ! {msg1, self()},
            receive
                msg1_reply ->
                    %%seq_trace:set_token([]),
                    io:format("There, I'm done!\n")
            end
    end.

-ifdef(SET_TRACE).
start_trace() ->
    io:format("Received starting message, setting up trace\n", []),
    seq_trace:set_token(label, 42),
    seq_trace:set_token(send, true),
    seq_trace:set_token('receive', true),
    seq_trace:set_token(timestamp, true),
    seq_trace:set_token(print, true).
-else.
start_trace() ->
    io:format("Received starting message, NOT setting up trace\n", []).
-endif.
