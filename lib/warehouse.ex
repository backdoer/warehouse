defmodule Warehouse do
  @moduledoc """
  Documentation for Warehouse.
  """

  alias Warehouse.Gears

  @doc """
  Hello world.
  """
  @spec call() :: [Integer.t()]
  def call do
    get_pegs()
    |> Gears.get_radius_of_first()
  end

  defp get_pegs do
    1..20
    |> Enum.reduce_while([], fn x, acc ->
      case get_input(x) do
        0 -> {:halt, acc}
        input -> {:cont, [input | acc]}
      end
    end)
    |> Enum.reverse()
  end

  defp get_input(x) do
    "What is the position of peg #{x}? (enter 0 to halt): "
    |> IO.gets()
    |> String.trim()
    |> String.to_integer()
    |> IO.inspect()
  end
end
