defmodule AdventOfCode2018.Day2.ChecksumCalculatorTest do
  use ExUnit.Case

  alias AdventOfCode2018.Day2.ChecksumCalculator

  @box_ids "test/day_2/fixtures/input.txt" |> File.stream!() |> Enum.map(& &1)

  describe "calculate/1" do
    test "returns checksum 12" do
      box_ids = ["abcdef", "bababc", "abbcde", "abcccd", "aabcdd", "abcdee", "ababab"]
      assert ChecksumCalculator.calculate(box_ids) == 12
    end

    test "returns checksum for input" do
      assert ChecksumCalculator.calculate(@box_ids) == 5880
    end
  end

  describe "common" do
    test "returns difference for fgij" do
      box_ids = ["abcde", "fghij", "klmno", "pqrst", "fguij", "axcye", "wvxyz"]
      assert ChecksumCalculator.common(box_ids) == "fgij"
    end

    test "returns difference for input" do
      assert ChecksumCalculator.common(@box_ids) == "tiwcdpbseqhxryfmgkvjujvza\n"
    end
  end
end
