defmodule Ksa.DataTypes.Noun do
  @moduledoc """
  Find the nouns in the sentence
  """
  alias Ksa.Support.StringHelper
  alias Ksa.Ets.DictFile
  alias Ksa.Structs.Noun

  @spec match(String.t()) :: list
  def match(sentence) when is_bitstring(sentence) do
    String.split(sentence, " ")
    |> Enum.flat_map(fn word ->
      # Custom logic
      StringHelper.split(word)
      |> Enum.map(fn part ->
        match(word, part)
      end)
    end)
    |> Enum.filter(fn x -> x != nil end)
  end

  @spec match(String.t(), String.t()) :: Ksa.t()
  defp match(word, part) do
    cond do
      DictFile.find(part, "noun/bible.txt") -> %Noun{word: word, part: part, subtype: "bible"}
      DictFile.find(part, "noun/brand.txt") -> %Noun{word: word, part: part, subtype: "brand"}
      DictFile.find(part, "noun/company_names.txt") -> %Noun{word: word, part: part, subtype: "company name"}
      DictFile.find(part, "noun/congress.txt") -> %Noun{word: word, part: part, subtype: "congress"}
      DictFile.find(part, "noun/entities.txt") -> %Noun{word: word, part: part, subtype: "entity"}
      DictFile.find(part, "noun/fashion.txt") -> %Noun{word: word, part: part, subtype: "fashion"}
      DictFile.find(part, "noun/foreign.txt") -> %Noun{word: word, part: part, subtype: "foreign"}
      DictFile.find(part, "noun/geolocations.txt") -> %Noun{word: word, part: part, subtype: "geolocation"}
      DictFile.find(part, "noun/kpop.txt") -> %Noun{word: word, part: part, subtype: "kpop"}
      DictFile.find(part, "noun/lol.txt") -> %Noun{word: word, part: part, subtype: "lol"}
      DictFile.find(part, "noun/names.txt") -> %Noun{word: word, part: part, subtype: "name"}
      DictFile.find(part, "noun/neologism.txt") -> %Noun{word: word, part: part, subtype: "neologism"}
      DictFile.find(part, "noun/nouns.txt") -> %Noun{word: word, part: part, subtype: "noun"}
      DictFile.find(part, "noun/pokemon.txt") -> %Noun{word: word, part: part, subtype: "pokemon"}
      DictFile.find(part, "noun/profane.txt") -> %Noun{word: word, part: part, subtype: "profane"}
      DictFile.find(part, "noun/slangs.txt") -> %Noun{word: word, part: part, subtype: "slang"}
      DictFile.find(part, "noun/spam.txt") -> %Noun{word: word, part: part, subtype: "spam"}
      DictFile.find(part, "noun/twitter.txt") -> %Noun{word: word, part: part, subtype: "twitter"}
      DictFile.find(part, "noun/wikipedia_title_nouns.txt") -> %Noun{word: word, part: part ,subtype: "wikipedia"}
      true -> nil
    end
  end
end
