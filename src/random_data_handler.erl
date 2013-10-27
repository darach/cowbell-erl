-module(random_data_handler).

-define(ASCY, "abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWZYZ").
-define(CT, <<"content-type">>).
-define(TP, <<"text/plain">>).
-define(MIME_TYPE, {?CT,?TP}).

%%
%% API
%%

-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

%%
%% API
%%

init(_Type, Req, Args) ->
    {ok, Req, Args}.

handle(Req, State) ->
    {Method,Req2} = cowboy_req:method(Req),
    HasBody = cowboy_req:has_body(Req2),
    Body = cowboy_req:body(Req2),
    [Size] = State,
    {ok, Req3} = process(Method,HasBody,Body,Size,Req2),
    {ok, Req3, State}.

terminate(_Reason, _Req, _State) ->
    ok.

%%
%% internal
%%

process(<<"GET">>,_HasBody,_Body,Size,Req) ->
    cowboy_req:reply(200, [?MIME_TYPE], random_data(payload_size(Size)), Req);

process(<<"POST">>,false,_Body,_Size,Req) ->
    cowboy_req:reply(400, [], <<"Missing body.\n">>, Req);

process(<<"POST">>,true,{ok, Body, _},Size,Req) ->
    Size2 = payload_size(Size),
    {Code, Msg} = case erlang:size(Body) of
        Size2 -> {200, "" };
        _ -> {400, "Incorrect body length.\n"}
    end,
    cowboy_req:reply(Code, [{<<"content-type">>, <<"application/octet-stream">>}], Msg , Req).

payload_size(b128) -> 128;
payload_size(k1) -> 1024;
payload_size(k10) -> 10240;
payload_size(k100) -> 102400;
payload_size(m1) -> 1048576.

random_data(Size) ->
    random_data(Size, ?ASCY).

random_data(Size, Chars) ->
    lists:foldl(
        fun(_, Acc) -> [lists:nth(random:uniform(erlang:length(Chars)), Chars)] ++ Acc end,
        [], lists:seq(1, Size)).

