defmodule Roman do

  def convert(n) do
    conversion = [
      { 1000, "M" },
      { 900, "CM" },
      { 500,  "D" },
      { 400, "CD" },
      { 100,  "C" },
      { 90,  "XC" },
      { 50,   "L" },
      { 40,  "XL" },
      { 10,   "X" },
      {  9,  "IX" },
      {  5,   "V" },
      {  4,  "IV" },
      {  1,   "I" }
    ]
    convert_r(n,conversion,"")
  end

  defp convert_r(0,_,acc) do
    acc
  end

  defp convert_r(n,[h|t],acc) do
    x = div(n,elem(h,0))
    value = elem(h,0)
    numeral = elem(h,1)
    if x > 0 do
      convert_r(n - value * x,t,acc <> String.duplicate(numeral,x))
    else
      convert_r(n,t,acc)
    end
  end

end
