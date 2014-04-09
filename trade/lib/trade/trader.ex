defmodule Trade.Trader do
  use GenFSM.Behaviour

  defrecord State name: "",
    other=nil,
    own_items=[],
    other_items=[],
    monitor=nil,
    from

  def start_link(name) do
    :gen_fsm.start_link(__MODULE__,[name],[])
  end

  def trade(own_pid,other_pid)
    :gen_fsm:sync_send_event(own_pid, { :negotiate, other_pid }, 30000)
  end

  # Callbacks

  def init(_args) do
    { :ok, :idle, State.new }
  end

  # Idle state

  def idle({ :ask_negotiate, other_pid },state) do
    ref = monitor(process,other_pod)
    notice(state,"#{other_pid} asked for a trade negotiation.")
    { :next_state, :idle_wait, State.new(other: other_pid,monitor: ref) }
  end

  def negotitate do

  end

  # Private functions

  defp notice(state[name: name],str,args) do
    IO.puts "#{[name|args]} #{str}"
  end
end
