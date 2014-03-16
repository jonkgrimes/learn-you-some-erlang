defmodule TradeFSM do
  use GenFSM.Behaviour

  defrecord State, name: "",
    :other,
    :own_items=[],
    :other_items=[],
    :monitor,
    :from

  # Public API
  def start(name) do
    :gen_fsm.start(__MODULE__,[name],[])
  end

  # Callbacks
end
