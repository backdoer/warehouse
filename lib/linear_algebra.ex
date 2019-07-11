defmodule LinearAlgebra do
  @moduledoc """
  Module containing logic for solving systems of linear equations
  via the Gaussian elimination method
  """

  def solve_system_of_equations(matrix), do: reduce(matrix)

  @doc """
  Returns a row equivalent matrix on reduced row echelon form.
  ## Examples
    
      iex> LinearAlgebra.reduce(
      ...>    [
      ...>      [Fraction.new(1), Fraction.new(1), Fraction.new(2), Fraction.new(1)],
      ...>      [Fraction.new(2), Fraction.new(1), Fraction.new(6), Fraction.new(4)],
      ...>      [Fraction.new(1), Fraction.new(2), Fraction.new(2), Fraction.new(3)]
      ...>    ]
      ...>  )
      [ Fraction.new(-5), Fraction.new(2), Fraction.new(2) ]
  """
  @spec reduce([[number]]) :: [[number]]
  def reduce(matrix), do: reduce(matrix, 0)

  defp reduce(matrix, row_number) do
    row = Enum.at(matrix, row_number)
    non_zero_column = Enum.find_index(row, fn val -> val.numerator != 0 end)
    matrix = pivot(matrix, row_number, non_zero_column)

    if non_zero_column == length(row) - 1 or row_number == length(matrix) - 1 do
      Enum.map(matrix, &Enum.at(&1, -1))
    else
      reduce(matrix, row_number + 1)
    end
  end

  defp pivot(matrix, row_number, column_number) do
    pivot_row = Enum.at(matrix, row_number)
    pivot_element = Enum.at(pivot_row, column_number)

    matrix
    |> List.delete_at(row_number)
    |> Enum.map(fn val ->
      subtract(
        val,
        multiply_row_by_constant(
          pivot_row,
          Fraction.division(Enum.at(val, column_number), pivot_element)
        )
      )
    end)
    |> List.insert_at(
      row_number,
      multiply_row_by_constant(
        pivot_row,
        Fraction.division(Fraction.new(1, 1), pivot_element)
      )
    )
  end

  defp multiply_row_by_constant(row, constant) do
    Enum.map(row, fn x -> Fraction.multiply(x, constant) end)
  end

  defp subtract(row1, row2) do
    for {a, b} <- Enum.zip(row1, row2), do: Fraction.subtraction(a, b)
  end
end
