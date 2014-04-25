defmodule AlgorithimsTest do
  use ExUnit.Case

  test "add a vertex to graph" do
    graph = %Graph{}

    graph = Graph.add_vertex(graph,"Houston")

    assert Enum.count(graph.vertices) == 1
  end

  test "get a vertex with the value" do
    graph = %Graph{}
    graph = Graph.add_vertex(graph,"Houston")

    vertex = Graph.get_vertex(graph,"Houston")

    assert %Vertex{value: "Houston"} == vertex
  end

end
