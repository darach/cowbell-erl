-module(cowbell_app).

-behaviour(application).

%%
%% API
%%

-export([start/2]).
-export([stop/1]).

%%
%% API
%%

start(_Type, _Args) ->
    Dispatch = cowboy_router:compile([
        {'_', [
            {"/bench/throughput/1k", random_data_handler, [k1]},
            {"/bench/throughput/10k", random_data_handler, [k10]},
            {"/bench/throughput/100k", random_data_handler, [k100]},
            {"/bench/throughput/1m", random_data_handler, [m1]} ]} ]),
        {ok, _} = cowboy:start_http(http, 100, [{port, 8080}], [{env, [{dispatch, Dispatch}]}]),
    cowbell_sup:start_link().

stop(_State) ->
    ok.
