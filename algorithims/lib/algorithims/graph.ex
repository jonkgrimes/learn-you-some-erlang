defmodule Graph do

  defstruct vertices: HashSet.new

  def add_vertex(graph,name) do
    vertex = %Vertex{ name: name }
    %{graph | vertices: HashSet.put(graph.vertices,vertex)}
  end

  def get_vertex(graph,name) do
    Enum.find(graph.vertices, fn(v) -> v.name == name end)
  end

end
