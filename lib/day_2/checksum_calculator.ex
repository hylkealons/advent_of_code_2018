defmodule AdventOfCode2018.Day2.ChecksumCalculator do
  def calculate(box_ids) do
    calculate_checksum(box_ids, %{})
  end

  def common([box_id | left] = box_ids) do
    case find_common(box_id, box_ids) do
      {:found, result} -> result
      :not_found -> common(left)
    end
  end

  defp find_common(box_id, [next_box_id | left]) do
    diff = to_charlist_diff(box_id, next_box_id)
    if length(diff) == 1 do
        {:found, common_between_box_ids(box_id, next_box_id)}
    else
      find_common(box_id, left)
    end
  end

  defp find_common(_, _), do: :not_found

  defp common_between_box_ids(box_id1, box_id2) do
    charlist1 = String.to_charlist(box_id1)
    charlist2 = String.to_charlist(box_id2)

    differences = charlist1
    |> Enum.zip(charlist2)
    |> Enum.filter(fn {c1, c2} -> c1 == c2 end)
    |> Enum.map(& elem(&1, 1))
    |> to_string
  end

  defp to_charlist_diff(string1, string2) do
    charlist1 = String.to_charlist(string1)
    charlist2 = String.to_charlist(string2)

    differences = charlist1
    |> Enum.zip(charlist2)
    |> Enum.reject(fn {c1, c2} -> c1 == c2 end)
  end

  defp calculate_checksum([], checksum_array) do
    Enum.reduce(checksum_array, 1, fn {_, checksum}, acc ->
      checksum * acc
    end)
  end

  defp calculate_checksum([box_id | left], checksum_array) do
    counts = count_for_box_id(box_id)

    checksum_array =
      checksum_array
      |> update_checksum_array(counts, 2)
      |> update_checksum_array(counts, 3)

    calculate_checksum(left, checksum_array)
  end

  defp count_for_box_id(box_id) do
    box_id
    |> String.codepoints()
    |> Enum.reduce(%{}, fn letter, counter ->
      current_count = Map.get(counter, letter, 0)
      Map.put(counter, letter, current_count + 1)
    end)
    |> Map.values()
  end

  defp update_checksum_array(checksum_array, counts, times) do
    if times in counts do
      current = Map.get(checksum_array, times, 0)
      Map.put(checksum_array, times, current + 1)
    else
      checksum_array
    end
  end
end
