defmodule Mix.Tasks.Benchmark do
  @moduledoc """
  Benchmark implemntation
  """

  use Mix.Task
  alias Warehouse.Gears
  alias Warehouse.V2.Gears, as: GearsV2

  @doc """
  Collect input from user of the position of the pegs and then call
  Warehouse.Gears to get radius of all gears
  """
  def run(_) do
    Application.ensure_all_started(:warehouse)
    pegs = [4, 30, 50, 70, 80, 100, 120]

    Benchee.run(
      %{
        "native_elixir" => fn -> GearsV2.get_radiuses(pegs) end,
        "python" => fn -> Gears.get_radiuses(pegs) end
      },
      time: 10,
      memory_time: 2
    )
  end
end
