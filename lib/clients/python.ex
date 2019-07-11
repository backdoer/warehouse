defmodule Warehouse.Clients.Python do
  @moduledoc """
  Module for making calls to python
  """
  use GenServer

  @python_file_dir "python"

  # Client
  #
  def start_link(_) do
    {:ok, pid} = :python.start_link([{:python_path, '#{python_file_path()}'}])

    GenServer.start_link(__MODULE__, pid, name: __MODULE__)
  end

  def solve_system_of_equations(matrix) do
    GenServer.call(
      __MODULE__,
      {:call, :linear_algebra, :solve_system_of_equations, [matrix]}
    )
  end

  defp python_file_path, do: Path.join(:code.priv_dir(:warehouse), @python_file_dir)

  # Server (callbacks)

  @impl true
  def init(pid) do
    {:ok, pid}
  end

  @impl true
  def handle_call({:call, module, function, args}, _from, pid) do
    {:reply, :python.call(pid, module, function, args), pid}
  end
end
