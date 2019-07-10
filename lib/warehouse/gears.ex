defmodule Warehouse.Gears do
  @moduledoc """
  Gears documentation
  """

  alias Warehouse.GaussianElimination
  alias Warehouse.Matrix

  @doc """
  Takes in list of peg positions, generate the linear algebra matrix with the rules,
  and then pass to a linear algebra function to solve the matrix.

  Returns:
  a) the radiuses of the pegs as a list of [a, b] where a/b is the radius
  b) :error if no solution is found

  ## Examples

      iex> Gears.get_radiuses([4, 30, 50])
      [[12, 1], [14, 1], [6, 1]]
  """
  @spec get_radiuses([Integer.t()]) :: [[]] | :error
  def get_radiuses(pegs) do
    pegs
    |> Matrix.generate()
    |> GaussianElimination.solve()
  end
end
