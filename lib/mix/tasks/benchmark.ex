defmodule Mix.Tasks.Benchmark do
  @moduledoc """
  Benchmark implemntation
  """

  use Mix.Task
  alias Warehouse.Gears
  alias Warehouse.V2.Gears, as: GearsV2

  @doc """
  Benchmark the 2 different implementations
  """
  def run(_) do
    Application.ensure_all_started(:warehouse)

    Benchee.run(
      %{
        "native_elixir" => fn input -> GearsV2.get_radiuses(input) end,
        "python" => fn input -> Gears.get_radiuses(input) end
      },
      inputs: %{
        "Small (4)" => [4, 30, 50, 60],
        "Medium (8)" => [4, 30, 50, 60, 80, 100, 120, 135],
        "Bigger (12)" => [4, 30, 50, 60, 80, 100, 120, 135, 150, 160, 180, 250, 300, 326]
      },
      time: 10,
      memory_time: 2
    )
  end
end
