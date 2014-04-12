defmodule Trade.Trader do
  use GenFSM.Behaviour

  defrecord State, name: "", other: nil, own_items: [],
    other_items: [], monitor: nil, from: nil

  def start_link(name) do
    :gen_fsm.start_link(__MODULE__,[name],[])
  end

  def trade(own_pid,other_pid) do
    :gen_fsm.sync_send_event(own_pid, { :negotiate, other_pid }, 30000)
  end

  # Callbacks

  def init(_args) do
    { :ok, :idle, State.new }
  end

  # Idle state before any trade is done
  # We ask the other player for a negotiation and wait
  # for our own user to accept the trade. We store the other Pid
  # for future uses
  def idle({ :ask_negotiate, other_pid },state) do
    ref = Process.monitor(other_pid)
    notice(state,"asked for a trade negotiation.",[other_pid])
    { :next_state, :idle_wait, State.new(other: other_pid,monitor: ref) }
  end

  def idle(event,data) do
    unexpected(:idle,event)
    { :next_state, :idle, data }
  end

  def idle({ :negotiate, other_pid },from,state) do
    ask_negotiate(other_pid,self())
    notice(state,"asking user #{other_pid} for a trade",[other_pid])
    ref = Process.monitor(other_pid)
    { :next_state, :idle_wait, State.new(other: other_pid,monitor: ref) }
  end

  def idle(event,_from,data) do
    unexpected(:idle,event)
    { :next_state, :idle, data }
  end 

  # Negotiate state

  def negotitate do
     
  end
  
  # Client-to-client API

  def ask_negotiate(other_pid,own_pid) do
    :gen_fsm.send_event(other_pid, { :ask_negotiate, own_pid })
  end

  # Private functions

  defp notice(state,str,args) do
    name = [state.name|args]
    IO.puts "#{name}: #{str}"
  end

  defp unexpected(state,msg) do
    IO.puts "#{self()} received unknown event #{msg} while in state #{state}"
  end
end
