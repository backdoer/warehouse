defmodule Warehouse.Gears.Matrix do
  @moduledoc """
  Gears matrix documentation
  """

  @doc """
  Takes in list of peg positions and returns the matrix representation
  to be solved by a linear algebra solution. The rows consist of each rule
  regarding gears adding up to equal the distance between the pegs. The last 
  row contains the rule that the last peg must be half the size of the first peg.

  ## Examples

      iex> Warehouse.Matrix.generate([4, 30, 50])
      [
        [1, 1, 0, 26],
        [0, 1, 1, 20],
        [1, 0, -2, 0]
      ]
  """
  @spec generate([Integer.t()]) :: [[]] | :error
  def generate(pegs) do
    peg_count = Enum.count(pegs)

    pegs
    |> Enum.with_index()
    |> generate_matrix(peg_count)
  end

  defp generate_matrix([first, second | []], peg_count) do
    last_row =
      Enum.map(0..peg_count, fn index ->
        cond do
          index == 0 -> fraction(1)
          index == peg_count - 1 -> fraction(-2)
          true -> fraction(0)
        end
      end)

    [generate_row(first, second, peg_count), last_row]
  end

  defp generate_matrix([first, second | tail], peg_count) do
    [generate_row(first, second, peg_count) | generate_matrix([second | tail], peg_count)]
  end

  defp generate_row({first_value, first_index}, {second_value, second_index}, peg_count) do
    Enum.map(0..peg_count, fn index ->
      cond do
        index == first_index -> fraction(1)
        index == second_index -> fraction(1)
        index == peg_count -> fraction(abs(second_value - first_value))
        true -> fraction(0)
      end
    end)
  end

  defp fraction(value), do: Fraction.new(value)
end
