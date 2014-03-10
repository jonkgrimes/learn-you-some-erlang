ExUnit.start

defmodule CalcTest do
  use ExUnit.Case

  test "addition" do
    assert Calc.rpn("2 3 +") == 5
  end

  test "subtraction" do
    assert Calc.rpn("3 2 -") == 1
  end

  test "multiplication" do
    assert Calc.rpn("2 3 *") == 6
  end

  test "division" do
    assert Calc.rpn("10 5 /") == 2
  end

  test "exponent" do
    assert Calc.rpn("5 2 ^") == 25
  end

  test "natural log" do
    assert Calc.rpn("2.7 ln") == :math.log(2.7)
  end

  test "log" do
    assert Calc.rpn("2.7 log10") == :math.log10(2.7)
  end

  test "multiple terms" do
    assert Calc.rpn("10 4 3 + 2 * -") == -4
    assert Calc.rpn("10 4 3 + 2 * - 2 /") == -2.0
    assert Calc.rpn("90 34 12 33 55 66 + * - + -") == 4037
  end

  test"raises badmatch" do
    assert_raise MatchError, fn ->
      Calc.rpn("90 34 12 33 55 66 + * - +")
    end
  end
end
