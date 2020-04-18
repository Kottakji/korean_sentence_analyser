defmodule Ksa.Support.StringHelper do
  @moduledoc """
  Helper functions
  """

  @doc """
  Splits our word into all matchable parts

  ## Examples
    iex> Ksa.Support.StringHelper.split("서울시장")
    ["서","서울","서울시","서울시장","울","울시","울시장","시","시장","장"]
  """
  @spec split(String.t()) :: list
  def split(text) when is_bitstring(text) do
    text
    |> String.split("", trim: true)
    |> do_split([])
  end

  defp do_split_from_tail([], acc) when is_list(acc) do
    acc
    |> List.flatten()
  end

  defp do_split_from_tail([_head | tail], acc) when is_list(tail) and is_list(acc) do
    list = tail |> Enum.map(fn x -> String.replace(x, String.first(x), "") end)

    do_split_from_tail(list, [acc | list])
  end

  defp do_split([], acc) when is_list(acc) do
    do_split_from_tail(acc, acc)
  end

  defp do_split(list, acc) when is_list(list) and is_list(acc) do
    {value, remaining} = List.pop_at(list, -1)

    value = do_split(value, remaining)

    do_split(remaining, [value | acc])
  end

  defp do_split(value, remaining) when is_bitstring(value) and is_list(remaining) do
    {head, tail} =
      Enum.flat_map_reduce(
        remaining,
        value,
        fn x, acc ->
          {[x], acc}
        end
      )

    List.to_string(head) <> tail
  end
end
