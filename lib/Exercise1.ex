defmodule Exercise1 do
  @spec generate_sequence(list(String.t())) :: list(String.t())
  defp generate_sequence(range) do
    left = range |> hd() |> String.to_integer()
    right = range |> tl() |> hd() |> String.to_integer()
    (left..right)
    |> Enum.map(fn x -> x |> Integer.to_string() end)
  end

  @spec is_id_invalid_ex01?(String.t()) :: boolean()
  defp is_id_invalid_ex01?(id) do
    left = id |> String.slice(0..floor(String.length(id) / 2 - 1))
    right = id |> String.slice(floor(String.length(id) / 2)..String.length(id))
    left === right
  end

  @spec get_invalid_ids_sum_ex01(list(String.t())) :: list(String.t())
  defp get_invalid_ids_sum_ex01(range) do
    range
    |> Enum.filter(fn x -> x |> String.length() |> rem(2) === 0 end)
    |> Enum.filter(&is_id_invalid_ex01?/1)
    |> Enum.reduce(0, fn str, acc -> acc + String.to_integer(str) end)
  end

  @spec is_id_invalid_ex02?(String.t()) :: boolean()
  defp is_id_invalid_ex02?(id) do
    if (String.length(id) === 1) do
      false
    else
      (id <> id)
      |> String.slice(1..(String.length(id) * 2 - 2))
      |> String.contains?(id)
    end
  end

  @spec get_invalid_ids_sum_ex02(list(String.t())) :: list(String.t())
  defp get_invalid_ids_sum_ex02(range) do
    range
    |> Enum.filter(&is_id_invalid_ex02?/1)
    |> Enum.reduce(0, fn str, acc -> acc + String.to_integer(str) end)
  end

  @spec ex1(list(String.t())) :: integer()
  def ex1(lines) do
    lines
    |> hd()
    |> String.split(",")
    |> Enum.map(fn str -> str |> String.split("-") end)
    |> Enum.map(&generate_sequence/1)
    |> Enum.map(&get_invalid_ids_sum_ex01/1)
    |> Enum.reduce(0, fn x, acc -> acc + x end)
  end

  @spec ex2(list(String.t())) :: integer()
  def ex2(lines) do
    lines
    |> hd()
    |> String.split(",")
    |> Enum.map(fn str -> str |> String.split("-") end)
    |> Enum.map(&generate_sequence/1)
    |> Enum.map(&get_invalid_ids_sum_ex02/1)
    |> Enum.reduce(0, fn x, acc -> acc + x end)
  end
end
