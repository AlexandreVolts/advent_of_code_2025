defmodule Exercise2 do
  @spec get_max_digit_index(String.t(), integer()) :: non_neg_integer()
  defp get_max_digit_index(str, digit) do
    output = :binary.match(str, digit |> Integer.to_string())
    if (output === :nomatch) do
      get_max_digit_index(str, digit - 1)
    else
      {index, _len} = output
      index
    end
  end

  @spec get_max_digit_index(String.t(), integer()) :: integer()
  defp get_max_digit_index(str) do
    if (str |> String.length() === 1) do
      0
    else
      get_max_digit_index(str, 9)
    end
  end

  @spec find_highest_joltage(String.t(), non_neg_integer()) :: String.t()
  defp find_highest_joltage(battery, joltage_output) do
    if (joltage_output === 0) do
      ""
    else
      index = battery |> String.slice(0..-joltage_output//1) |> get_max_digit_index()
      short_battery = battery |> String.slice(index + 1..String.length(battery))

      String.at(battery, index) <> find_highest_joltage(short_battery, joltage_output - 1)
    end
  end

  @spec ex1(list(String.t())) :: integer()
  def ex1(lines) do
    lines
    |> Enum.map(fn battery -> find_highest_joltage(battery, 2) |> String.to_integer() end)
    |> Enum.reduce(0, fn x, acc -> acc + x end)
  end

  @spec ex2(list(String.t())) :: integer()
  def ex2(lines) do
    lines
    |> Enum.map(fn battery -> find_highest_joltage(battery, 12) |> String.to_integer() end)
    |> Enum.reduce(0, fn x, acc -> acc + x end)
  end
end
