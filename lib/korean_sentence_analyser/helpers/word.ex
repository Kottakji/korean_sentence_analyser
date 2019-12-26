defmodule KoreanSentenceAnalyser.Helpers.Word do
  alias KoreanSentenceAnalyser.DataTypes.Substantive
  alias KoreanSentenceAnalyser.DataTypes.Noun
  alias KoreanSentenceAnalyser.DataTypes.Adverb
  alias KoreanSentenceAnalyser.DataTypes.Adjective
  alias KoreanSentenceAnalyser.DataTypes.Verb
  alias KoreanSentenceAnalyser.DataTypes.Conjunction
  alias KoreanSentenceAnalyser.DataTypes.ModifiedNoun
  alias KoreanSentenceAnalyser.Helpers.Typo

  @doc """
  Find a word and get their type (verb, noun etc)
  """
  def find("") do
    nil
  end

  def find(word) do
    word = Typo.find(word)
    
    with nil <- Substantive.given_name(word),
         nil <- Substantive.family_name(word),
         nil <- Conjunction.conjunction(word),
         nil <- Noun.find(word),
         nil <- Adverb.find(word),
         nil <- Adjective.find(word),
         nil <- Verb.find(word),
         nil <- Substantive.given_name(word, true),
         nil <- Substantive.family_name(word, true),
         nil <- Noun.find_without_josa(word),
         nil <- ModifiedNoun.find(word),
         do: nil
  end

  @doc """
  Get the remaining part of the word, removing the match from either the beginning or the end
  """
  def get_remaining(word, match) do
    cond do
      String.starts_with?(word, match) ->
        case Regex.replace(Regex.compile!("^" <> match, "u"), word, "") do
          "" -> nil
          result -> result
        end

      String.ends_with?(word, match) ->
        case Regex.replace(Regex.compile!(match <> "$", "u"), word, "") do
          "" -> nil
          result -> result
        end

      true ->
        nil
    end
  end
end
