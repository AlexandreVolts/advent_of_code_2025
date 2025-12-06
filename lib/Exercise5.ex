defmodule Exercise5 do
  @type operator :: (integer(), integer() -> integer())

  @spec compute_operator_along_col(list(list(integer())), operator(), non_neg_integer()) ::
          integer()
  defp compute_operator_along_col(numbers, operator, index) do
    numbers
    |> tl()
    |> Enum.reduce(hd(numbers) |> Enum.at(index), fn row, acc ->
      operator.(acc, row |> Enum.at(index))
    end)
  end

  @spec get_number_in_col(list(String.t()), non_neg_integer()) :: non_neg_integer()
  defp get_number_in_col(lines, index) do
    lines
    |> Enum.reverse()
    |> Enum.filter(fn line -> line |> String.at(index) !== " " end)
    |> Enum.map(fn line -> line |> String.at(index) |> String.to_integer() end)
    |> Enum.with_index()
    |> Enum.reduce(0, fn {digit, index}, acc -> acc + digit * :math.pow(10, index) end)
  end

  @spec ex1(list(String.t())) :: integer()
  def ex1(lines) do
    numbers =
      lines
      |> Utils.pop()
      |> Enum.map(fn line -> line |> Utils.str_to_integer_list() end)

    lines
    |> Utils.last()
    |> String.split(" ", trim: true)
    |> Enum.with_index()
    |> Enum.reduce(0, fn {operator, index}, acc ->
      acc + compute_operator_along_col(numbers, if(operator === "*", do: &*/2, else: &+/2), index)
    end)
  end

  @spec ex2(list(String.t())) :: integer()
  def ex2(lines) do
    operators = lines |> Utils.last() |> String.split(" ", trim: true)

    numbers =
      lines
      |> hd()
      |> String.split("", trim: true)
      |> Enum.with_index()
      |> Enum.map(fn {_char, index} -> get_number_in_col(lines |> Utils.pop(), index) end)
    0
  end
end
