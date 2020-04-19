defmodule Ksa.DataTypes.Adjective do
  @moduledoc """
  Find the adjectives in the sentence
  """
  alias Ksa.Support.String, as: StringHelper
  alias Ksa.Ets.DictFile
  alias Ksa.Structs.Adjective
  
  @spec match(String.t()) :: list
  def match(sentence) when is_bitstring(sentence) do
    String.split(sentence, " ")
    |> Enum.flat_map(fn word ->
      StringHelper.split(word)
      |> Enum.map(fn part ->
        match(word, Ksa.Support.Conjugation.conjugate(part))
      end)
    end)
    |> Enum.filter(fn x -> x != nil end)
  end

  @spec match(String.t(), String.t()) :: Ksa.t()
  defp match(word, part) do
    cond do
      DictFile.find(part, "adjective/adjective.txt") -> %Adjective{word: word, part: part}
      true -> nil
    end
  end
end
