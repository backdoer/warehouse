defmodule Warehouse.V2.Gears do
  @moduledoc """
  Gears documentation
  """

  alias Warehouse.V2.Gears.Matrix

  @minimum_gear_size 1

  @doc """
  Takes in list of peg positions, generate the linear algebra matrix with the rules,
  and then pass to a linear algebra function to solve the matrix.

  Returns:
  a) the radiuses of the pegs as a list of [a, b] where a/b is the radius
  b) :error if no solution is found

  ## Examples

      iex> Gears.get_radiuses([4, 30, 50])
      [
        Fraction.new(12),
        Fraction.new(14),
        Fraction.new(6)
      ]
  """
  @spec get_radiuses([Integer.t()]) :: [[]] | :error
  def get_radiuses(pegs) do
    pegs
    |> Matrix.generate()
    |> LinearAlgebra.solve_system_of_equations()
    |> handle_response()
  end

  defp handle_response(gears) do
    if gears_valid?(gears) do
      gears
    else
      [-1, -1]
    end
  end

  # make sure all gears are greater than 1
  defp gears_valid?(gears) do
    gears
    |> List.flatten()
    |> Enum.all?(fn gear -> Fraction.to_decimal(gear) >= @minimum_gear_size end)
  end
end
