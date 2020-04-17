defmodule KSA.Support.StringHelper do
  @moduledoc """
  Helper functions
  """
  
  @doc """
  Splits our text into all possible strings
  """
  @spec split(String.t()) :: list
  def split(text) when is_bitstring(text) do
    text
    |> String.split("", trim: true)
    |> do_split([])
  end
  
  defp do_split([], acc) when is_list(acc) do
    acc
  end
  
  defp do_split(list, acc) when is_list(list) and is_list(acc) do
    {value, remaining} = List.pop_at(list, -1)
    
    value = do_split(value, remaining)
    
    do_split(remaining, [value | acc])
  end
  
  defp do_split(value, remaining) when is_bitstring(value) and is_list(remaining) do
    {head, tail} = Enum.flat_map_reduce(
      remaining,
      value,
      fn x, acc ->
        {[x], acc}
      end
    )
  
    List.to_string(head) <> tail
  end
end