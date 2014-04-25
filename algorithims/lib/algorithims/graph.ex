defmodule Graph do

  defstruct vertices: []

  def add_vertex(graph,value) do
    vertex = %Vertex{ value: value }
    %{graph | vertices: [vertex]}
  end

  def get_vertex(graph,value) do
    Enum.find(graph.vertices, fn(v) -> v.value == value end)
  end

end
