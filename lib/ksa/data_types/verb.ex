defmodule Ksa.DataTypes.Verb do
  @moduledoc """
  Find the verb in the sentence
  """
  alias Ksa.Support.String, as: StringHelper
  alias Ksa.Ets.DictFile
  alias Ksa.Structs.Verb
  alias Ksa.Structs.Conjugated

  @spec match(String.t()) :: list
  def match(sentence) when is_bitstring(sentence) do
    String.split(sentence, " ")
    |> Enum.flat_map(fn word ->
      StringHelper.split(word)
      |> Enum.map(fn part ->
        [
          match(word, part),
          Enum.map(
            Ksa.Support.Conjugation.conjugate(part),
            fn conjugated = %Conjugated{} ->
              match(word, conjugated)
            end
          ),
          Enum.map(
            Ksa.Support.Conjugation.conjugate_irregular(part),
            fn conjugated = %Conjugated{} ->
              match(word, conjugated)
            end
          )
        ]
      end)
      |> List.flatten()
    end)
    |> Enum.filter(fn x -> x != nil end)
  end

  @spec match(String.t(), String.t()) :: Verb.t() | nil
  defp match(word, part) when is_bitstring(word) and is_bitstring(part) do
    cond do
      DictFile.find(part, "verb/verb.txt") -> %Verb{word: word, match: part}
      true -> nil
    end
  end

  @spec match(String.t(), String.t()) :: Verb.t() | nil
  defp match(word, conjugated = %Conjugated{}) when is_bitstring(word) and is_map(conjugated) do
    cond do
      DictFile.find(conjugated.conjugated, "verb/verb.txt") ->
        %Verb{word: word, match: conjugated.conjugated, conjugated: conjugated}

      true ->
        nil
    end
  end
end
