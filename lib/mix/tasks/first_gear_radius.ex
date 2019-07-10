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
    Enum.reduce_while(iterations, [], &handle_input/2)
  end

  defp handle_input(x, acc) do
    case get_input(x) do
      0 ->
        handle_exit_request(x, acc)

      :error ->
        IO.puts("Please enter a number greater than 1 and less than 10,000")
        handle_input(x, acc)

      input ->
        IO.puts(input)
        {:cont, [input | acc]}
    end
  end

  defp handle_exit_request(x, acc) when x > 2, do: {:halt, acc}

  defp handle_exit_request(x, acc) do
    IO.puts("Please enter at least two pegs")
    handle_input(x, acc)
  end

  defp get_input(x) do
    "What is the position of peg #{x}? (enter 0 to halt): "
    |> IO.gets()
    |> String.trim()
    |> validate_and_cast_input()
  end

  defp validate_and_cast_input(input) do
    with {integer, _} <- Integer.parse(input),
         true <- integer >= 0 && integer <= 10_000 do
      integer
    else
      _ -> :error
    end
  end
end
