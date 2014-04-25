defmodule Vertex do
  defstruct name: nil, edges: []

  def add_edge(from,to,weight \\ 0) do
    edge = %Edge{from: from,to: to,weight: weight}
    %{from | edges: [edge]}
    %{to | edges: [edge]}
    edge
  end

end
