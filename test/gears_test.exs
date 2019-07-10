defmodule Warehouse.GearsTest do
  use ExUnit.Case
  alias Warehouse.Gears
  doctest Warehouse.Gears

  describe "get_radiuses/1" do
    test "should return correct radiuses as a ratio" do
      assert Gears.get_radiuses([4, 8]) == [[8, 3], [4, 3]]
    end

    test "should return [-1, -1] if no solution is found" do
      assert Gears.get_radiuses([1, 5, 1224]) == [-1, -1]
    end
  end
end
