defmodule Cases do
  def insert(x,[]) do
    [x]
  end

  def insert(x,set) do
    case List.member(x,set) do
      true ->
        set
      false ->
        [x|set]
    end
  end

  def beach(temprature) do
    case temprature do
      { :celsius, n } when n >=2 and n <= 45 ->
        "favorable"
      { :kelvin, n } when n >= 294 and n <= 318 ->
        "scientifically favorable"
      { :fahrenheit, n } when n >= 68 and n <= 113 ->
        "favorable in the US"
      _ ->
        "avoid the beach"
    end
  end
end
