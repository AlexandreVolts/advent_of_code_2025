defmodule Exercise3 do
  @spec get_walls_around(list(String.t()), non_neg_integer(), non_neg_integer()) :: integer()
  defp get_walls_around(lines, x, y) do
    [
      {-1, -1}, {-1, 0}, {-1, 1},
      {0, -1}, {0, 1},
      {1, -1}, {1, 0}, {1, 1}
    ]
    |> Enum.filter(fn {dir_x, dir_y} -> Utils.at(lines, x + dir_x, y + dir_y) === "@" end)
    |> length()
  end

  @spec is_roll_acessible_by_forklift?(list(String.t()), integer()) :: boolean()
  defp is_roll_acessible_by_forklift?(lines, index) do
    x = rem(index, lines |> hd() |> String.length())
    y = floor(index / length(lines))

    get_walls_around(lines, x, y) < 4
  end

  @spec ex1(list(String.t())) :: integer()
  def ex1(lines) do
    lines
    |> Enum.join()
    |> String.split("")
    |> Enum.with_index()
    |> Enum.filter(fn {char, _index} -> char === "@" end)
    |> Enum.filter(fn {_char, index} -> is_roll_acessible_by_forklift?(lines, index - 1) end)
    |> length()
  end

  @spec ex2(list(String.t())) :: integer()
  def ex2(lines) do
    lines
    0
  end
end
