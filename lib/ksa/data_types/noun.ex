defmodule Ksa.DataTypes.Noun do
  @moduledoc """
  Find the nouns in the sentence
  """
  alias Ksa.Support.StringHelper

  @spec match(String.t()) :: list
  def match(sentence) when is_bitstring(sentence) do
    String.split(sentence, " ")
    |> Enum.flat_map(fn word ->
      # Custom logic
      StringHelper.split(word)
      |> Enum.map(fn part ->
        match(word, part, "noun/nouns.txt")
      end)
    end)
    |> Enum.filter(fn x -> x != nil end)
  end

  @spec match(String.t(), String.t(), String.t()) :: Ksa.t()
  defp match(word, part, path) do
    case Ksa.Ets.DictFile.find(part, "noun/nouns.txt") do
      nil -> nil
      _ -> %Ksa.Structs.Noun{word: word, part: part}
    end
  end
end
