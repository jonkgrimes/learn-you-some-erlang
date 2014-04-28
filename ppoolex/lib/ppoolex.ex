defmodule Ppoolex do
  use Application.Behaviour

  # See http://elixir-lang.org/docs/stable/Application.Behaviour.html
  # for more information on OTP Applications
  def start(_type, _args) do
    Ppoolex.SuperSupervisor.start_link
  end

  def stop(_state)  do
    :ok
  end

  def start_pool(name, limit, {m, f, a}) do
    Ppoolex.SuperSupervisor.start_pool(name, limit, {m, f, a})
  end

  def stop_pool(name) do
    Ppoolex.SuperSupervisor.stop_pool(name)
  end

  def run(name, args) do
    Ppoolex.Server.run(name, args)
  end

  def async_queue(name, args) do
    Ppoolex.Server.async_queue(name, args)
  end

  def sync_queue(name, args) do
    Ppoolex.Server.sync_queue(name, args)
  end
end
