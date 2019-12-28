defmodule Word do
  alias Substantive
  alias Noun
  alias Adverb
  alias Adjective
  alias Verb
  alias Conjunction
  alias ModifiedNoun
  alias Determiner
  alias Typo

  @doc """
  Find a word and get their type (verb, noun etc)
  """
  def find("") do
    nil
  end

  def find(word) do
    word = Typo.find(word)

    with nil <- Determiner.find(word),
         nil <- Substantive.given_name(word),
         nil <- Substantive.family_name(word),
         nil <- Conjunction.conjunction(word),
         nil <- Noun.find(word),
         nil <- Noun.find_without_determiner(word),
         nil <- Noun.find_without_grammar(word),
         nil <- Adverb.find(word),
         nil <- Adjective.find(word),
         nil <- Verb.find(word),
         nil <- Substantive.given_name(word, :remove_josa),
         nil <- Substantive.family_name(word, :remove_josa),
         nil <- Noun.find_without_josa(word),
         nil <- ModifiedNoun.find(word),
         do: nil
  end

  @doc """
  Get the remaining part of the word, removing the match from either the beginning or the end
  """
  def get_remaining(word, match) do
    cond do
      String.starts_with?(word, match) -> Regex.replace(Regex.compile!("^" <> match, "u"), word, "")
      String.ends_with?(word, match) -> Regex.replace(Regex.compile!(match <> "$", "u"), word, "")
      true ->
        ""
    end
  end
end
