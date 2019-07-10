defmodule Warehouse.GaussianElimination do
  @moduledoc """
  Module containing logic for solving systems of linear equations
  via the Gaussian elimination method
  """

  alias Warehouse.PythonClient

  @doc """
  """
  @spec solve([]) :: []
  def solve(matrix) do
    PythonClient.call(:test, :solve_system_equations, [matrix])
  end
end
