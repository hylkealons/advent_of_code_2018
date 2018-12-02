defmodule AdventOfCode.ResultingFrequencyTest do
  use ExUnit.Case

  alias AdventOfCode2018.Day1.ResultingFrequency

  @frequencies "test/day_1/fixtures/input.txt" |> File.stream!() |> Enum.map(& &1)

  describe "calculate/1" do
    test "sums correctly" do
      assert ResultingFrequency.calculate(["+1", "+1", "+1"]) == 3
    end

    test "subtracts correctly" do
      assert ResultingFrequency.calculate(["-1", "-2", "-3"]) == -6
    end

    test "calculates correctly" do
      assert ResultingFrequency.calculate(["+1", "+1", "-2"]) == 0
    end

    test "calculate for frequency input" do
      assert ResultingFrequency.calculate(@frequencies) == 439
    end
  end

  describe "first_frequency" do
    test "first 0 twice" do
      assert ResultingFrequency.first_frequency(["+1", "-1"]) == 0
    end

    test "reaches 10 twice" do
      assert ResultingFrequency.first_frequency(["+3", "+3", "+4", "-2", "-4"]) == 10
    end

    test "reaches 5 twice" do
      assert ResultingFrequency.first_frequency(["-6", "+3", "+8", "+5", "-6"]) == 5
    end

    test "reaches 14 twice" do
      assert ResultingFrequency.first_frequency(["+7", "+7", "-2", "-7", "-4"]) == 14
    end

    test "find for frequency input" do
      assert ResultingFrequency.first_frequency(@frequencies) == 124_645
    end
  end
end
