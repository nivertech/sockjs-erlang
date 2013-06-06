-module(sockjs_multiplex_channel).

-export([new/2, send/2, close/1, close/3, info/1]).

new(Conn, Topic) ->
    {?MODULE, [Conn, Topic]}.

send(Data, {?MODULE, [Conn, Topic]}=THIS) ->
    Conn:send(iolist_to_binary(["msg", ",", Topic, ",", Data])).

close(THIS) ->
    close(1000, "Normal closure", THIS).

close(_Code, _Reason, {?MODULE, [Conn, Topic]}=THIS) ->
    Conn:send(iolist_to_binary(["uns", ",", Topic])).

info({?MODULE, [Conn, Topic]}=THIS) ->
    Conn:info(THIS) ++ [{topic, Topic}].