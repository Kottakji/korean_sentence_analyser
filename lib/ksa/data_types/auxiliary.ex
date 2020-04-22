defmodule Ksa.DataTypes.Auxiliary do
  @moduledoc """
  Find the auxiliary in the sentence
  """
  alias Ksa.Support.String, as: StringHelper
  alias Ksa.Ets.DictFile
  alias Ksa.Structs.Auxiliary

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

  @spec match(String.t(), String.t()) :: Noun.t()
  defp match(word, part) do
    cond do
      DictFile.find(part, "auxiliary/conjunctions.txt") -> %Auxiliary{word: word, match: part, subtype: "conjunction"}
      DictFile.find(part, "auxiliary/determiner.txt") -> %Auxiliary{word: word, match: part, subtype: "determiner"}
      DictFile.find(part, "auxiliary/exclamation.txt") -> %Auxiliary{word: word, match: part, subtype: "exclamation"}
      true -> nil
    end
  end
end
