defmodule Calc do
  def rpn(list) do
    [response] = List.foldl(String.split(list," "),[],&rpn(&1,&2))
    response
  end

  def rpn("+",[n1,n2|s]) do
    [n2 + n1 | s]
  end

  def rpn("sum",[n1,n2,n3,n4|s]) do
    [n4+n3+n2+n1|s]
  end

  def rpn("-",[n1,n2|s]) do
    [n2 - n1 | s]
  end

  def rpn("*",[n1,n2|s]) do
    [n2 * n1 | s]
  end

  def rpn("prod",[n1,n2,n3,n4|s]) do
    [n4*n3*n2*n1|s]
  end

  def rpn("/",[n1,n2|s]) do
    [n2/n1|s]
  end

  def rpn("^",[n1,n2|s]) do
    [:math.pow(n2,n1)|s]
  end

  def rpn("ln",[n|s]) do
    [:math.log(n)|s]
  end

  def rpn("log10",[n|s]) do
    [:math.log10(n)|s]
  end

  def rpn(x,stack) do
    [read(x)|stack]
  end

  def read(n) do
    case Float.parse(n) do
      :error ->
        list_to_integer(n)
      { f, _ } ->
        f
    end
  end
end
