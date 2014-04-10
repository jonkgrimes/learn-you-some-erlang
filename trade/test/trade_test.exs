defmodule TradeTest do
  use ExUnit.Case

  setup do
    { status, pid } = Trade.Trader.start_link("Bob")
    { status, pid: pid }
  end

  test "idle to idle_waiting transition",meta do
    msg = { :ask_negotiate, self() }
    transition = :gen_fsm.send_event(meta[:pid],msg)
    assert transition == :ok
  end

  test "idle needs to get ask_negotiate first",meta do
    msg = { :negotiate, self() }
    transition = :gen_fsm.send_event(meta[:pid],msg)
    assert transition == :ok
  end
end
