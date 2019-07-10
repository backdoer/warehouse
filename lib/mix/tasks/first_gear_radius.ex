defmodule Mix.Tasks.FirstGearRadius do
  @moduledoc """
  Collect input from user of the position of the pegs and then call
  Warehouse.Gears to get radius of all gears
  """

  use Mix.Task
  alias Warehouse.Gears

  @doc """
  Collect input from user of the position of the pegs and then call
  Warehouse.Gears to get radius of all gears
  """
  def run(_) do
    ensure_started()

    get_pegs()
    |> Gears.get_radiuses()
    |> List.first()
    |> IO.inspect(label: "The answer is")
  end

  defp ensure_started do
    {:ok, _} = Application.ensure_all_started(:warehouse)
  end

  defp get_pegs do
    1..20
    |> collect_user_input()
    |> Enum.reverse()
  end

  defp collect_user_input(iterations) do
    Enum.reduce_while(iterations, [], fn x, acc ->
      case get_input(x) do
        0 -> {:halt, acc}
        input -> {:cont, [input | acc]}
      end
    end)
  end

  defp get_input(x) do
    "What is the position of peg #{x}? (enter 0 to halt): "
    |> IO.gets()
    |> String.trim()
    |> String.to_integer()
    |> IO.inspect()
  end
end
