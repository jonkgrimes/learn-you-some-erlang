defmodule VertexTest do
  use ExUnit.Case

  test "add an edge between to vertexes" do
    from = %Vertex{name: "Houston"}
    to = %Vertex{name: "Austin" }

    edge = Vertex.add_edge(from,to,5)

    assert edge.from == from
    assert edge.to == to
    assert edge.weight == 5
  end

  test "get neighbors" do
    flunk
  end

end
