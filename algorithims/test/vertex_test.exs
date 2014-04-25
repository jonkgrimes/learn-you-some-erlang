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

  test "get neighbors of a vertex" do
    a = %Vertex{name: "A"}
    b = %Vertex{name: "B"}
    c = %Vertex{name: "C"}
    
    Vertex.add_edge(a,b,1)
    Vertex.add_edge(b,c,1)
    Vertex.add_edge(a,c,1)

    assert Vertex.neighbors(a) == [b,c]
    assert Vertex.neighbors(b) == [a,c]
    assert Vertex.neighbors(c) == [a,b]
  end

end
