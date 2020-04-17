defmodule KSA.DataTypes.Noun do
  @moduledoc """
  Find the nouns in the sentence
  """
  alias KSA.Support.StringHelper
  
  @spec match(String.t()) :: list
  def match(text) when is_bitstring(text) do
    String.split(text, " ")
    |> Enum.flat_map(fn word ->
      StringHelper.split(word) # Custom logic
      |> Enum.map(
           fn part ->
             match(word, part, "noun/nouns.txt")
           end
         )
    end)
  end
  
  
  @spec match(String.t(), String.t(), String.t()) :: KoreanSentenceAnalyser.t()
  defp match(word, part, path) do
    case KSA.ETS.DictFile.find(part, "noun/nouns.txt") do
      nil -> %KSA.Structs.Noun{word: part, accuracy: 0}
      _ -> %KSA.Structs.Noun{word: part, accuracy: accuracy(word, part)}
    end
  end
  
  @spec accuracy(String.t(), String.t()) :: integer
  defp accuracy(word, part) do
    cond do
      # Equals
      word == part and String.length(part) > 1 -> 100
      word == part and String.length(part) == 1 -> 60
      # Starts with
      String.starts_with?(word, part) and String.length(part) > 1 -> 70
      true -> 0
    end
  end
end