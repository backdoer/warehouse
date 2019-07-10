defmodule Warehouse.LinearAlgebra do
  @moduledoc """
  Module containing logic for solving systems of linear equations
  via the Gaussian elimination method
  """

  def solve_system_of_equations(matrix) do
    matrix
    |> reduce()
  end

  
  @doc"""
  Returns a row equivalent matrix on reduced row echelon form.
  ## Examples
    
      iex> Matrix.reduce([[1.0, 1.0, 2.0, 1.0],
      ...>                [2.0, 1.0, 6.0, 4.0],
      ...>                [1.0, 2.0, 2.0, 3.0]])
      [[1.0, 0.0, 0.0, -5.0],
       [0.0, 1.0, 0.0, 2.0],
       [0.0, 0.0, 1.0, 2.0]]
  """
  @spec reduce([[number]]) :: [[number]]
  def reduce(a), do: reduce(a, 0)
  defp reduce(a, i) do
    r = Enum.at(a, i)
    j = Enum.find_index(r, fn(e) -> e != 0 end)
    a = pivot(a, i, j)
    
    unless j === length(r) - 1 or
           i === length(a) - 1
      do
        reduce(a, i + 1)
      else
	a
    end
  end

  defp pivot(a, n, m) do
    pr = Enum.at(a, n)  #Pivot row
    pe = Enum.at(pr, m) #Pivot element

    a
    |> List.delete_at(n)
    |> Enum.map(&sub(&1, scalar(pr, Enum.at(&1, m) / pe)))
    |> List.insert_at(n, scalar(pr, 1 / pe))
  end

  defp scalar(v, s) do
    Enum.map(v, fn(x) -> x*s end)
  end

  defp sub(u, v) do
    add(u, Enum.map(v, fn(x) -> -x end))
  end

  defp add(u, v) do
    for {a, b} <- Enum.zip(u, v), do: a + b
  end
end
