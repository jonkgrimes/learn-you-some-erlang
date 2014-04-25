defmodule AlgorithimsTest do
  use ExUnit.Case

  test "add a vertex to graph" do
    graph = %Graph{}

    graph = Graph.add_vertex(graph,"Houston")

    assert Enum.count(graph.vertices) == 1
  end

  test "ensure we can't add the same vertex twice" do
    flunk
  end

  test "get a vertex from the graph" do
    graph = %Graph{}
    graph = Graph.add_vertex(graph,"Houston")

    vertex = Graph.get_vertex(graph,"Houston")

    assert %Vertex{value: "Houston"} == vertex
  end

  test "getting a non-existent vertex from the graph returns nil" do
    flunk
  end

  test "test whether two vertices are adjacent" do
    flunk
  end

  test "get all the neighbors for a vertex" do
    flunk
  end

  test "remove a vertex from the graph" do
    flunk
  end

end
