defmodule Calc do
  def rpn(list) when is_string(list) do
    IO.puts "Hello"
    [response] = List.foldl(String.split(list," "),[],&rpn(&1,&2))
    response
  end

  def rpn("+",[n1,n2|s]) do
    [n2 + n1 | s]
  end
end
