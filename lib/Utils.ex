defmodule Utils do
  @type non_neg_vector() :: {non_neg_integer(), non_neg_integer()}

  @spec at([String.t()], integer(), integer()) :: String.t() | nil
  def at(lines, x, y) do
    if Utils.is_outside?(lines, x, y) do
      nil
    else
      lines |> Enum.at(y) |> String.at(x)
    end
  end

  @spec get_map_dimensions([String.t()]) :: non_neg_vector()
  def get_map_dimensions(lines), do: {hd(lines) |> String.length(), length(lines)}

  @spec str_to_integer_list([String.t()], String.t()) :: [integer()]
  def str_to_integer_list(str, separator \\ " ") do
    str |> String.split(separator, trim: true) |> Enum.map(&String.to_integer/1)
  end

  @spec pop(list(any())) :: list(any())
  def pop(list) do
    if length(list) === 0 do
      []
    else
      list |> Enum.reverse() |> tl() |> Enum.reverse()
    end
  end

  @spec is_outside?(list(String.t()), integer(), integer()) :: boolean()
  def is_outside?(lines, x, y) do
    x < 0 or y < 0 or y >= length(lines) or x >= Enum.at(lines, y) |> String.length()
  end
end
