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
           {"/bench/throughput/128b", random_data_handler, [b128]},
            {"/bench/throughput/1k", random_data_handler, [k1]},
            {"/bench/throughput/10k", random_data_handler, [k10]},
            {"/bench/throughput/100k", random_data_handler, [k100]},
            {"/bench/throughput/1m", random_data_handler, [m1]} ]} ]),
        {ok, _} = cowboy:start_http(http, 100, [{port, 8080},
                                                {backlog, 128},
                                                {nodelay, true},
                                                {max_connections, 61000}],
                                    [{env, [{dispatch, Dispatch},
                                            {max_keepalive, 100},
                                            {compress, false},
                                            {max_empty_lines, 5},
                                            {max_header_name_length, 64},
                                            {max_header_value_length, 4096},
                                            {max_headers, 100},
                                            {max_keepalive, 100},
                                            {max_request_line_length, 4096},
                                            {timeout, 30000}]}]),
    cowbell_sup:start_link().

stop(_State) ->
    ok.
