-module(event_server).
-compile(export_all).

-record(state, { events, %% list of #event{} records
                  clients }). %% list Pids

%% this server should be able to:
%% 1 - Recevie subscriptons from the client
%% 2 - Add events to be tracked for the client
%% 3 - Cancel events

%% intialize the events server
init() ->
  loop(#state{events=orddict:new(),clients=orddict:new()}).

%% main loop
loop(S = #state{}) ->
  receive
    { Pid, MsgRef, { subscribe, Client }} ->
      Ref = erlang:monitor(process,Client),
      NewClients = orddict:store(Ref,Client,S#state.clients),
      Pid ! { MsgRef, ok },
      loop(S#state{clients=NewClients});
    { Pid, MsgRef, { add, Name, Description, TimeOut }} ->
      %% do stuff
    { Pid, MsgRef, { cancel, Name }} ->
      %% do stuff
    { done, Name } ->
      %% do stuff
    shutdown ->
      %% do stuff
    { 'DOWN', Ref, process, _Pid, _Reason } ->
      %% do stuff
    code_change ->
      %% do stuff
    Unknown ->
      io:format("Unknown message: ~p~n",[Unknown]),
      loop(State)
  end.

valid_datetime({Date,Time}) ->
  try
    datetime:valid_date(Date) andalso valid_time(Time)
  catch
    error:function_clause -> %% not in {{Y,M,D}, {H,Min,S}} format
      false
  end;
valid_datetime(_) ->
  false.

valid_time({H,M,S}) -> valid_time(H,M,S).
valid_time(H,M,S) when H >= 0, H < 24,
                       M >= 0, M < 60,
                       S >= 0, S < 60 -> true;
valid_time(_,_,_) -> false.
