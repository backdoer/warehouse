defmodule Mix.Tasks.Benchmark do
  @moduledoc """
  Benchmark implemntation
  """

  use Mix.Task
  alias Warehouse.Gears

  @doc """
  Collect input from user of the position of the pegs and then call
  Warehouse.Gears to get radius of all gears
  """
  def run(_) do
    IO.puts("HI")
  end
end

