defmodule Warehouse.GaussianElimination do
  @moduledoc """
  Module containing logic for solving systems of linear equations
  via the Gaussian elimination method
  """

  alias Warehouse.Clients.Python

  @doc """
  """
  @spec solve([]) :: []
  def solve(matrix) do
    Python.solve_system_of_equations(matrix)
  end
end
