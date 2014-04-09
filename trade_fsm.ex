defmodule TradeFSM do
  use GenFSM.Behaviour

  defrecord State, name: "",
    :other,
    :own_items=[],
    :other_items=[],
    :monitor,
    :from

  ## Public API
  def start(name) do
    :gen_fsm.start(__MODULE__,[name],[])
  end

  def start_link(name) do
    :gen_fsm.start_link(__MODULE__,[name],[])
  end

  def trade(own_pid,other_pid) do
    :gen_fsm.sync_send_event(own_pid, { :negotiate, other_pid }, 30000)
  end

  def accept_trade(own_pid) do
    :gen_fsm.sync_send_event(own_pid, :accept_negotiate)
  end

  def make_offer(own_pid,item) do
    :gen_fsm.send_event(own_pid, { :make_offer, item })
  end

  def retract_offer(own_pid,item) do
    :gen_fsm.send_event(own_pid, { :retract_offer, item })
  end

  def ready(own_pid) do
    :gen_fsm.sync_send_event(own_pid,:ready,:infinity)
  end

  def cancel(own_pid) do
    :gen_fsm.sync_send_all_state_event(own_pid, :cancel)
  end

  ## Callbacks
end
