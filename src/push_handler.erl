-module(push_handler).

%% API
-export([init/2]).


init(Req, _Opts) ->
  gproc:send({p,l,ws_listeners},{text, cowboy_req:binding(message, Req)}),
  Req2 = cowboy_req:reply(200, Req),
  {ok, Req2,_Opts}.