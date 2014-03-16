-module(trade_fsm).
-behavior(gen_fsm).

-export([start/1,start_link/1,trade/2,accept_trade/1,
    make_offer/2,retract_offer/2,ready/1,cancel/1]).
-export([init/1,handle_event/3,handle_sync_event/4,handle_info/3,
    terminate/3,code_change/4,
    % custom state names
    idle/2,idle/3,idle_wait/2,idle_wait/3,negotiate/2,
    negotiate/3,wait/2,ready/2,ready/3]).

-record(state, { name="",
                  other,
                  ownitems=[],
                  otheritems=[],
                  monitor,
                  from }).

init(Name) ->
  { ok, idle, #state{name=Name}}.

%% send players a notice. this could be messages to their clients
%% but for our purposes, outputting to the shell is enough
notice(#state{name=N}, Str, Args) ->
  io:format("~s: "++Str++"~n", [N|Args]).

%% log unexpected messages
unexpected(Msg, State) ->
  io:format("~p received unknown event ~p while in state ~p~n",
    [self(),Msg,State]).

%% idle
idle({ ask_negotiate, OtherPid }, S#state{}) ->
  Ref = monitor(process, OtherPid),
  notice(S, "~p asked for trade a negotiation", [OtherPid]),
  { next_state, idle_wait, S#state{other=OtherPid,monitor=Ref}};
idle(Event,Date) ->
  unexpected(Event, idle),
  { next_state, idle, Data}.

%% idle_wait
idle_wait({ ask_negotiate, OtherPid }, S=#state{other=OtherPid}) ->
  gen_fsm:reply(S#state.from, ok),
  notice(S, "starting negotiation", []),
  { next_state, negotiate, S};
idle_wait({ accept_negotiate, OtherPid }, S=#state{other=OtherPid}) ->
  gen_fsm:reply(S#state.from, ok),
  notice(S, "starting negotiation", []),
  { next_state, negotiate, S};
idle_wait(Event,Data) ->
  unexpected(Event, idle_wait),
  { next_state, idle_wait, Data}.

idle_wait(accept_negotiate, _From, S=#state{other=OtherPid}) ->
  accept_negotiate(OtherPid, self()),
  notice(S, "accepting negotiation", []),
  {reply, ok, negotiate, S};
idle_wait(Event, _From, Data) ->
  unexpected(Event, idle_wait),
  {next_state, idle_wait, Data}.

%% add an item to an item list
add(Item, Items) ->
  [Item | Items].

%% remove an item from an item list
remove(Item, Items) ->
  Items -- [Item].

%%% Public API
start(Name) ->
  gen_fsm:start(?MODULE, [Name], []).

start_link(Name) ->
  gen_fsm:start_link(?MODULE, [Name], []).

%% ask for a begin session. Returns when/if the other accepts.
trade(OwnPid, OtherPid) ->
  gen_fsm:sync_send_event(OwnPid, { negotiate, OtherPid }, 30000).

%% accept someone's trade offer
accept_trade(OwnPid) ->
  gen_fsm:sync_send_event(OwnPid, accept_negotitate).

%% send an item on the table to be traded
make_offer(OwnPid, Item) ->
  gen_fsm:send_event(OwnPid, { make_offer, Item }).

%% cancel trade offer
retract_offer(OwnPid, Item) ->
  gen_fsm:sent_event(OwnPid, { retract_offer, Item }).

%% Mention that you're ready for a trade. When other player
%% also declares being ready, the trade is done.
ready(OwnPid) ->
  gen_fsm:sync_send_event(OwnPid, ready, infinity).

%% cancel transaction
cancel(OwnPid) ->
  gen_fsm:sync_send_all_state_event(OwnPid,cancel).

%% ask the other FSM's Pid for a trade session
ask_negotiate(OtherPid,OwnPid) ->
  gen_fsm:send_event(OtherPid, { ask_negotiate, OwnPid }).

%% forward the client message accepting the transaction
accept_negotiate(OtherPid,OwnPid) ->
  gen_fsm:send_event(OtherPid, { accept_negotiate, OwnPid }).

%% forward a clients offer
do_offer(OtherPid,Item) ->
  gen_fsm:send_event(OtherPid, { do_offer, Item }).

%% forward a clients offer cancellation
undo_offer(OtherPid, Item) ->
  gen_fsm:send_event(OtherPid, { undo_offer, Item }).

%% ask the other side if he's ready to trade
are_you_ready(OtherPid) ->
  gen_fsm:send_event(OtherPid, are_you_ready).

%% reply that the side is not ready to trade i.e. it is not in wait state
not_yet(OtherPid) ->
  gen_fsm:send_event(OtherPid, not_yet).

%% tells the other fsm that the user is currently waiting
%% for the ready state. State should transition to 'ready'
am_ready(OtherPid) ->
  gen_fsm:send_event(OtherPid, 'ready!').

%% acknowledge that the fsm is in a ready state
ack_trans(OtherPid) ->
  gen_fsm:send_event(OtherPid, ack).

%% ask if ready to commit
ask_commit(OtherPid) ->
  gen_fsm:send_event(OtherPid, ask_commit).

%% begin synchronous commit
do_commit(OtherPid) ->
  gen_fsm:sync_send_event(OtherPid, do_commit).

notify_cancel(OtherPid) ->
  gen_fsm:send_all_state_event(OtherPid, cancel).
