ExUnit.start

defmodule CalcTest do
  use ExUnit.Case

  test "addition" do
    assert Calc.rpn("2 3 +") == 5
  end
end
