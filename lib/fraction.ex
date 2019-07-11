defmodule Fraction do
  @moduledoc """
  Fraction functions

  Besides a few small tweaks, this code largely came from the following library:
  https://github.com/lermannen/elixir-fraction
  """
  defstruct [:numerator, :denominator]

  def new(numerator, denominator \\ 1)
  def new(x, _y) when is_float(x), do: raise(ArithmeticError)
  def new(_x, y) when is_float(y), do: raise(ArithmeticError)
  def new(_n, 0), do: raise(ArithmeticError)

  def new(numerator, denominator) do
    gcd = gcd(numerator, denominator)
    n = div(numerator, gcd)
    d = div(denominator, gcd)
    sign = sign(n * d)
    %Fraction{numerator: sign * Kernel.abs(n), denominator: Kernel.abs(d)}
  end

  defp sign(x) when x < 0, do: -1
  defp sign(x) when x >= 0, do: 1

  def add(lhs = %Fraction{}, %Fraction{numerator: 0, denominator: _d}) do
    lhs
  end

  def add(lhs = %Fraction{}, rhs = %Fraction{}) do
    Fraction.new(
      lhs.numerator * rhs.denominator + rhs.numerator * lhs.denominator,
      lhs.denominator * rhs.denominator
    )
  end

  def add(lhs, rhs), do: add(Fraction.new(lhs), Fraction.new(rhs))

  def subtraction(lhs = %Fraction{}, rhs = %Fraction{}) do
    Fraction.new(
      lhs.numerator * rhs.denominator - rhs.numerator * lhs.denominator,
      lhs.denominator * rhs.denominator
    )
  end

  def division(lhs = %Fraction{}, rhs = %Fraction{}) do
    Fraction.multiply(lhs, reciprocal(rhs))
  end

  def division(lhs, rhs), do: division(Fraction.new(lhs), Fraction.new(rhs))

  def multiply(lhs = %Fraction{}, rhs = %Fraction{}) do
    Fraction.new(
      lhs.numerator * rhs.numerator,
      lhs.denominator * rhs.denominator
    )
  end

  def reciprocal(f = %Fraction{}), do: Fraction.new(f.denominator, f.numerator)

  defp gcd(x, 0), do: x
  defp gcd(x, y), do: gcd(y, rem(x, y))

  def to_decimal(f = %Fraction{}), do: f.numerator / f.denominator

  def as_list(f = %Fraction{}), do: [f.numerator, f.denominator]
end
