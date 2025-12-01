defmodule Exercise0 do
  @type dial_state :: {integer(), integer()}

  @spec get_dial_rotation(String.t()) :: integer()
  defp get_dial_rotation(line) do
    n = line |> String.slice(1..-1//1) |> String.to_integer()

    if line |> String.at(0) === "R", do: n, else: -n
  end

  @spec rotate_dial(integer(), integer()) :: integer()
  defp rotate_dial(current, rotation) do
    n = rem(current + rotation, 100)

    if n < 0, do: 100 + n, else: n
  end

  @spec ex1(list(String.t())) :: integer()
  def ex1(lines) do
    lines
    |> Enum.reduce([50], fn line, acc ->
      acc ++ [Utils.last(acc) |> rotate_dial(get_dial_rotation(line))]
    end)
    |> Enum.filter(fn x -> x === 0 end)
    |> length()
  end

  @spec ex2(list(String.t())) :: integer()
  def ex2(_lines) do
    0
  end
end
