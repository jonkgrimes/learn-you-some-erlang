ExUnit.start

defmodule RomanTest do
  use ExUnit.Case

  test "0" do
    assert Roman.convert(0) == ""
  end

  test "1" do
    assert Roman.convert(1) == "I"
  end

  test "4" do
    assert Roman.convert(4) == "IV"
  end

  test "5" do
    assert Roman.convert(5) == "V"
  end

  test "9" do
    assert Roman.convert(9) == "IX"
  end

  test "10" do
    assert Roman.convert(10) == "X"
  end

  test "21" do
    assert Roman.convert(21) == "XXI"
  end

  test "40" do
    assert Roman.convert(40) == "XL"
  end

  test "50" do
    assert Roman.convert(50) == "L"
  end

  test "90" do
    assert Roman.convert(90) == "XC"
  end

  test "100" do
    assert Roman.convert(100) == "C"
  end

  test "109" do
    assert Roman.convert(109) == "CIX"
  end

  test "400" do
    assert Roman.convert(400) == "CD"
  end

  test "409" do
    assert Roman.convert(409) == "CDIX"
  end

  test "500" do
    assert Roman.convert(500) == "D"
  end

  test "900" do
    assert Roman.convert(900) == "CM"
  end

  test "1000" do
    assert Roman.convert(1000) == "M"
  end

  test "1954" do
    assert Roman.convert(1954) == "MCMLIV"
  end

  test "1990" do
    assert Roman.convert(1990) == "MCMXC"
  end

  test "2400" do
    assert Roman.convert(2400) == "MMCD"
  end
end
