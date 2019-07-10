defmodule Warehouse.PythonClient do
  @moduledoc """
  Module for making calls to python
  """
  use GenServer

  # Client
  #
  def start_link(_) do
    {:ok, pid} = :python.start_link([{:python_path, '#{python_file_path()}'}])

    GenServer.start_link(__MODULE__, pid, name: __MODULE__)
  end

  def call(module, function, args) do
    GenServer.call(__MODULE__, {:call, module, function, args})
  end

  defp python_file_path, do: Application.get_env(:warehouse, :python_file_path)

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
