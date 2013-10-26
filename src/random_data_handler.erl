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
    [Size] = State,
    {ok, Req2} = cowboy_req:reply(200, [?MIME_TYPE], random_data(payload_size(Size)), Req),
    {ok, Req2, State}.

terminate(_Reason, _Req, _State) ->
    ok.

%%
%% internal
%%

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

