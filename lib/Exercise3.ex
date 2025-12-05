defmodule Exercise3 do
  @spec get_roll_indexes(list(String.t())) :: list(non_neg_integer())
  defp get_roll_indexes(lines) do
    lines
    |> Enum.join()
    |> String.split("")
    |> Enum.with_index()
    |> Enum.filter(fn {char, _index} -> char === "@" end)
    |> Enum.map(fn {_char, index} -> index - 1 end)
  end

  @spec get_walls_around(list(String.t()), non_neg_integer(), non_neg_integer()) :: integer()
  defp get_walls_around(lines, x, y) do
    [
      {-1, -1},
      {-1, 0},
      {-1, 1},
      {0, -1},
      {0, 1},
      {1, -1},
      {1, 0},
      {1, 1}
    ]
    |> Enum.filter(fn {dir_x, dir_y} -> Utils.at(lines, x + dir_x, y + dir_y) === "@" end)
    |> length()
  end

  @spec is_roll_accessible_by_forklift?(list(String.t()), integer()) :: boolean()
  defp is_roll_accessible_by_forklift?(lines, index) do
    x = rem(index, lines |> hd() |> String.length())
    y = floor(index / length(lines))

    get_walls_around(lines, x, y) < 4
  end

  @spec convert_rolls_to_positions(list(String.t())) :: list(Utils.non_neg_vector())
  defp convert_rolls_to_positions(lines) do
    width = lines |> hd() |> String.length()

    lines
    |> get_roll_indexes()
    |> Enum.map(fn index -> {rem(index, width), floor(index / length(lines))} end)
  end

  @spec is_roll_position_accessible_by_forklift?(
          list(Utils.non_neg_vector()),
          Utils.non_neg_vector()
        ) :: boolean()
  defp is_roll_position_accessible_by_forklift?(positions, {x, y}) do
    positions
    |> Enum.count(fn {other_x, other_y} -> abs(other_x - x) <= 1 && abs(other_y - y) <= 1 end) < 5
  end

  @spec remove_rolls(list(Utils.non_neg_vector())) :: non_neg_integer()
  defp remove_rolls(positions) do
    to_be_kept =
      positions
      |> Enum.filter(fn current ->
        !is_roll_position_accessible_by_forklift?(positions, current)
      end)

    to_be_removed = length(positions) - length(to_be_kept)

    if to_be_removed === 0 do
      0
    else
      to_be_removed + remove_rolls(to_be_kept)
    end
  end

  @spec ex1(list(String.t())) :: integer()
  def ex1(lines) do
    lines
    |> get_roll_indexes()
    |> Enum.count(fn index -> is_roll_accessible_by_forklift?(lines, index) end)
  end

  @spec ex2(list(String.t())) :: integer()
  def ex2(lines) do
    lines
    |> convert_rolls_to_positions()
    |> remove_rolls()
  end
end
