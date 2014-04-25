defmodule Graph do

  defstruct nodes: []

  def add_node(graph,value) do
    node = %Graph.Node{ value: value }
    %{graph | nodes: [node]}
  end

  def add_node(graph,from,to,edge) do
    node = Graph.get_node(graph,from)
    new_node = node.add_neighbor("Austin",150)

    nodes = [graph.nodes | new_node]

    %{graph | nodes: [nodes]}
  end

  def get_node(graph,value) do
    Enum.find(graph.nodes, fn(n) -> n.value == value end)
  end

end
