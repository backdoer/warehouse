defmodule Warehouse.Application do
  @moduledoc """
  Podium reporting microservice
  """
  use Application
  import Supervisor.Spec, warn: false

  def start(_type, _args) do
    # Define workers and child supervisors to be supervised
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options

    opts = [strategy: :one_for_one, name: Warehouse.Supervisor]
    Supervisor.start_link([], opts)
  end
end
