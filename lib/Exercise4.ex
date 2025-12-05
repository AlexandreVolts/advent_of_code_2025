defmodule Exercise4 do
  @type range() :: {non_neg_integer(), non_neg_integer()}

  @spec str_range_to_int_range(String.t()) :: range()
  defp str_range_to_int_range(line) do
    parts = line |> Utils.str_to_integer_list("-")
    {hd(parts), hd(tl(parts))}
  end

  @spec get_ranges(list(String.t())) :: list(range())
  defp get_ranges(lines) do
    lines
    |> Enum.filter(fn line -> line |> String.contains?("-") end)
    |> Enum.map(&str_range_to_int_range/1)
  end

  @spec get_available_ingredients(list(String.t())) :: list(non_neg_integer())
  defp get_available_ingredients(lines) do
    lines
    |> Enum.filter(fn line -> String.length(line) > 0 and !String.contains?(line, "-") end)
    |> Enum.map(&String.to_integer/1)
  end

  @spec is_in_range?(list(range()), non_neg_integer()) :: boolean()
  defp is_in_range?(ranges, x) do
    ranges |> Enum.any?(fn {min, max} -> x >= min and x <= max end)
  end

  @spec ex1(list(String.t())) :: integer()
  def ex1(lines) do
    ranges = lines |> get_ranges()
    lines
    |> get_available_ingredients()
    |> Enum.count(fn ingredient -> is_in_range?(ranges, ingredient) end)
  end

  @spec ex2(list(String.t())) :: integer()
  def ex2(lines) do
    0
  end
end
