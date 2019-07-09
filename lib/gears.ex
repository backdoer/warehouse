defmodule Warehouse.Gears do
  @moduledoc """
  Gears documentation
  """

  @doc """
  Takes in list of peg positions and returns:

  a) the radius of the first peg as [a, b] where a/b is the radius
    where the last peg has double the rpm of the first peg
  b) [-1, -1] if no solution can be found

  ## Examples

      iex> Gears.get_radius_of_first([4, 30, 50])
      [12, 1]
  """
  @spec get_radius_of_first([Integer.t()]) :: [Integer.t()]
  def get_radius_of_first(peg_positions) do
  end
end
