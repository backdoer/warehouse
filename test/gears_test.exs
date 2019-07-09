defmodule Warehouse.GearsTest do
  use ExUnit.Case
  alias Warehouse.Gears
  doctest Warehouse.Gears

  describe "get_radius_of_first/1" do
    test "should return correct radius as a ratio" do
      assert Gears.get_radius_of_first([4, 8]) == [8, 3]
    end

    test "should return [-1, -1] if no solution is found" do
      assert Gears.get_radius_of_first([1, 5, 1224]) == [-1, -1]
    end
  end
end
