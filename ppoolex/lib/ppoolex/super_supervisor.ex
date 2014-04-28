defmodule Ppoolex.SuperSupervisor do
  use Supervisor.Behaviour

  def start_link do
    :supervisor.start_link({:local, :ppoolex},__MODULE__, [])
  end

  def start_pool(name, limit, mfa) do
    worker Ppoolex.Supervisor,
      [name,limit,mfa],
      restart: :permanent,
      shutdown: 10500,
      modules: [Ppoolex.Supervisor]
  end

  def init([]) do
    tree = [
      worker(Ppoolex.Supervisor,
        [name,limit,mfa],
        restart: :permanent,
        shutdown: 10500,
        modules: [Ppoolex.Supervisor])
    ]

    supervise(tree, strategey: :one_for_one)
  end

end
