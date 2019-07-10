defmodule Warehouse.LinearAlgebra do
  @moduledoc """
  Module containing logic for solving systems of linear equations
  via the Gaussian elimination method
  """

  alias Warehouse.Clients.Python

  defdelegate solve_system_of_equations(matrix), to: Python
end
