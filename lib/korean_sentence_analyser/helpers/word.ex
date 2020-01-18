defmodule KSA.Word do
  @moduledoc false

  @doc """
  Find a word and get their type (verb, noun etc)
  """
  def find("") do
    nil
  end

  def find(word) when byte_size(word) > 3 do
    word = KSA.Typo.find(word)

    with nil <- KSA.Determiner.find(word),
         nil <- KSA.Substantive.given_name(word),
         nil <- KSA.Substantive.family_name(word),
         nil <- KSA.Noun.find(word),
         do: find(word, :main)
  end

  def find(word) do
    find(word, :main)
  end

  def find(word, :main) do
    word = KSA.Typo.find(word)

    with nil <- KSA.Determiner.find(word),
         nil <- KSA.Conjunction.find(word),
         nil <- KSA.Grammar.find(word),
         nil <- KSA.Substantive.given_name(word),
         nil <- KSA.Substantive.family_name(word),
         nil <- KSA.Noun.find(word),
         nil <- KSA.Noun.find_without_determiner(word),
         nil <- KSA.Noun.find_without_grammar(word),
         nil <- KSA.Suffix.find(word),
         nil <- KSA.Adverb.find(word),
         nil <- KSA.Adjective.find(word),
         nil <- KSA.ModifiedNoun.find(word),
         nil <- KSA.Verb.find(word),
         nil <- KSA.Noun.find_without_destructive_grammar(word),
         nil <- KSA.Substantive.given_name(word, :remove_josa),
         nil <- KSA.Substantive.family_name(word, :remove_josa),
         nil <- KSA.Noun.find_without_josa(word),
         nil <- KSA.Noun.find_wikipedia_title_noun(word),
         do: nil
  end

  @doc """
  Get the remaining part of the word, removing the match from either the beginning or the end
  """
  def get_remaining(word, match) do
    cond do
      String.starts_with?(word, match) ->
        Regex.replace(Regex.compile!("^" <> match, "u"), word, "")

      String.ends_with?(word, match) ->
        Regex.replace(Regex.compile!(match <> "$", "u"), word, "")

      true ->
        ""
    end
  end
end
