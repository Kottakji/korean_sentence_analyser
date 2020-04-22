defmodule Ksa.DataTypes.Substantive do
  @moduledoc """
  Find the substantive in the sentence
  """
  alias Ksa.Support.String, as: StringHelper
  alias Ksa.Ets.DictFile
  alias Ksa.Structs.Substantive

  @spec match(String.t()) :: list
  def match(sentence) when is_bitstring(sentence) do
    String.split(sentence, " ")
    |> Enum.flat_map(fn word ->
      StringHelper.split(word)
      |> Enum.flat_map(fn part ->
        [
          match(word, part),
          match(word, part, :suffix),
          match(word, part, :name)
        ]
      end)
    end)
    |> Enum.filter(fn x -> x != nil end)
  end

  @spec match(String.t(), String.t()) :: Substantive.t()
  defp match(word, part) do
    cond do
      DictFile.find(part, "substantives/modifier.txt") -> %Substantive{word: word, match: part, subtype: "modifier"}
      true -> nil
    end
  end

  @spec match(String.t(), String.t(), atom) :: Substantive.t()
  defp match(word, part, :suffix) when word == part do
    nil
  end

  @spec match(String.t(), String.t(), atom) :: Substantive.t()
  defp match(word, part, :suffix) do
    cond do
      String.ends_with?(word, part) and DictFile.find(part, "substantives/suffix.txt") -> %Substantive{word: word, match: part, subtype: "suffix"}
      true -> nil
    end
  end

  @spec match(String.t(), String.t(), atom) :: Substantive.t()
  defp match(_word, part, :name) when byte_size(part) != 9 do
    nil
  end

  @spec match(String.t(), String.t(), atom) :: Substantive.t()
  defp match(word, part, :name) when byte_size(part) == 9 do
    {family_name, given_name} = String.split_at(part, 1)

    cond do
      DictFile.find(family_name, "substantives/family_names.txt") != nil and DictFile.find(given_name, "substantives/given_names.txt") != nil ->
        %Substantive{word: word, match: part, subtype: "name"}

      true ->
        nil
    end
  end
end
