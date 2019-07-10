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

      iex> Warehouse.Gears.Matrix.generate([4, 30, 50])
      [
        [%Fraction{denominator: 1, numerator: 1}, %Fraction{denominator: 1, numerator: 1}, %Fraction{denominator: 1, numerator: 0}, %Fraction{denominator: 1, numerator: 26}],
        [%Fraction{denominator: 1, numerator: 0}, %Fraction{denominator: 1, numerator: 1}, %Fraction{denominator: 1, numerator: 1}, %Fraction{denominator: 1, numerator: 20}],
        [%Fraction{denominator: 1, numerator: 1}, %Fraction{denominator: 1, numerator: 0}, %Fraction{denominator: 1, numerator: -2}, %Fraction{denominator: 1, numerator: 0}]
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
          index == 0 -> Fraction.new(1)
          index == peg_count - 1 -> Fraction.new(-2)
          true -> Fraction.new(0)
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
        index == first_index -> Fraction.new(1)
        index == second_index -> Fraction.new(1)
        index == peg_count -> Fraction.new(abs(second_value - first_value))
        true -> Fraction.new(0)
      end
    end)
  end
end
