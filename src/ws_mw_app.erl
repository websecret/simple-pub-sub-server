-module(ws_mw_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

%% API.
start(_Type, _Args) ->
	Dispatch = cowboy_router:compile([
		{'_', [
			{"/", cowboy_static, {priv_file, ws_mw, "index.html"}},
			{"/subscribe", ws_handler, []},
			{"/push/:message", push_handler, []},
			{"/static/[...]", cowboy_static, {priv_dir, ws_mw, "static"}}
		]}
	]),
	{ok, _} = cowboy:start_http(http, 100, [{port, 8080}],
		[{env, [{dispatch, Dispatch}]}]),
	ws_mw_sup:start_link().

stop(_State) ->
	ok.
