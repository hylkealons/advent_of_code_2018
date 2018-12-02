defmodule AdventOfCode2018.Day1.ResultingFrequency do
  @moduledoc """
  URL: https://adventofcode.com/2018/day/1#part2
  """

  @typedoc """
  The frequency list exists of a frequencies as a string, e.g. ["-16", "+15"]
  """
  @type frequency_list :: [String.t()]

  @doc """
  Calculates the frequency based on a list of frequencies
  """
  @spec calculate(frequency_list) :: integer
  def calculate(frequency_list) do
    Enum.reduce(frequency_list, 0, &calculate_frequency(&2, &1))
  end

  @doc """
  Finds the first duplicated frequency result
  """
  @spec first_frequency(frequency_list, frequency_list) :: integer
  def first_frequency(frequency_list, result_frequencies \\ [0]) do
    case find_first_frequency(frequency_list, result_frequencies) do
      {:found, frequency} -> frequency
      {:not_found, result_frequencies} -> first_frequency(frequency_list, result_frequencies)
    end
  end

  defp find_first_frequency([], result_frequencies), do: {:not_found, result_frequencies}

  defp find_first_frequency([frequency | left], [current_frequency | _] = result_frequencies) do
    resulting_frequency = calculate_frequency(current_frequency, frequency)

    if Enum.member?(result_frequencies, resulting_frequency) do
      {:found, resulting_frequency}
    else
      find_first_frequency(left, [resulting_frequency | result_frequencies])
    end
  end

  defp calculate_frequency(current, "+" <> frequency) do
    current + frequency_to_integer(frequency)
  end

  defp calculate_frequency(current, "-" <> frequency) do
    current - frequency_to_integer(frequency)
  end

  defp frequency_to_integer(frequency) do
    {frequency, _} = Integer.parse(frequency)
    frequency
  end
end
