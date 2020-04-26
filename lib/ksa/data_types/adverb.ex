defmodule Ksa.DataTypes.Adverb do
  @moduledoc false
  alias Ksa.Support.String, as: StringHelper
  alias Ksa.Ets.DictFile
  alias Ksa.Structs.Adverb

  @spec match(String.t()) :: list
  def match(sentence) when is_bitstring(sentence) do
    String.split(sentence, " ")
    |> Enum.flat_map(fn word ->
      StringHelper.split(word)
      |> Enum.map(fn part ->
        match(word, part)
      end)
    end)
    |> Enum.filter(fn x -> x != nil end)
  end

  @spec match(String.t(), String.t()) :: Adverb.t()
  defp match(word, part) do
    cond do
      DictFile.find(part, "adverb/adverb.txt") -> %Adverb{word: word, match: part}
      true -> nil
    end
  end
end
