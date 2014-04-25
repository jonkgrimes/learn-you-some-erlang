defmodule AlgorithimsTest do
  use ExUnit.Case

  test "add a single node to graph" do
    graph = %Graph{}

    graph = Graph.add_node(graph,"Houston")

    assert Enum.count(graph.nodes) == 1
  end

  test "get a node with the value" do
    graph = %Graph{}
    graph = Graph.add_node(graph,"Houston")

    node = Graph.get_node(graph,"Houston")

    assert %Graph.Node{value: "Houston"} == node  
  end

  test "add a node to another" do
    graph = %Graph{}
    graph = Graph.add_node(graph,"Houston")

    graph = Graph.add_node(graph,"Houston","Austin",10)

    assert Enum.count(graph.nodes) == 2
  end
end
