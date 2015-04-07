-module(ws_handler).

-export([init/2]).
-export([websocket_handle/3]).
-export([websocket_info/3]).

init(Req, Opts) ->
  self() ! post_init,
  gproc:reg({p,l, ws_listeners}),
  {cowboy_websocket, Req, Opts, 120000}.

websocket_handle(_Data, Req, State) ->
  {ok, Req, State, hibernate}.

websocket_info(post_init, Req, State) ->
  {reply, {text, << "connected" >>}, Req, State};
websocket_info({text, Msg}, Req, State) ->
  {reply, {text, Msg}, Req, State};
websocket_info(_Info, Req, State) ->
  {ok, Req, State, hibernate}.

