defmodule KoreanSentenceAnalyser.Helpers.Word do
  alias KoreanSentenceAnalyser.DataTypes.Substantive
  alias KoreanSentenceAnalyser.DataTypes.Noun
  alias KoreanSentenceAnalyser.DataTypes.Adverb
  alias KoreanSentenceAnalyser.DataTypes.Adjective
  alias KoreanSentenceAnalyser.DataTypes.Verb
  alias KoreanSentenceAnalyser.DataTypes.Conjunction
  alias KoreanSentenceAnalyser.DataTypes.ModifiedNoun
  
  @doc """
  Find a word
  """
  def find("") do
    nil
  end
  
  def find(word) do
    with nil <- Substantive.given_name(word),
         nil <- Substantive.family_name(word),
         nil <- Conjunction.conjunction(word),
         nil <- Noun.bible(word),
         nil <- Noun.brand(word),
         nil <- Noun.company_name(word),
         nil <- Noun.congress(word),
         nil <- Noun.entity(word),
         nil <- Noun.fashion(word),
         nil <- Noun.foreign(word),
         nil <- Noun.geolocation(word),
         nil <- Noun.kpop(word),
         nil <- Noun.lol(word),
         nil <- Noun.name(word),
         nil <- Noun.neologism(word),
         nil <- Noun.nouns(word),
         nil <- Noun.pokemon(word),
         nil <- Noun.profane(word),
         nil <- Noun.slang(word),
         nil <- Noun.spam(word),
         nil <- Noun.twitter(word),
         nil <- Noun.wikipedia_title_noun(word),
         nil <- Adverb.adverb(word),
         nil <- Adjective.adjective(word),
         nil <- Verb.verb(word),
         nil <- Substantive.given_name(word, true),
         nil <- Substantive.family_name(word, true),
         nil <- Noun.bible(word, true),
         nil <- Noun.brand(word, true),
         nil <- Noun.company_name(word, true),
         nil <- Noun.congress(word, true),
         nil <- Noun.entity(word, true),
         nil <- Noun.fashion(word, true),
         nil <- Noun.foreign(word, true),
         nil <- Noun.geolocation(word, true),
         nil <- Noun.kpop(word, true),
         nil <- Noun.lol(word, true),
         nil <- Noun.name(word, true),
         nil <- Noun.neologism(word, true),
         nil <- Noun.nouns(word, true),
         nil <- Noun.pokemon(word, true),
         nil <- Noun.profane(word, true),
         nil <- Noun.slang(word, true),
         nil <- Noun.spam(word, true),
         nil <- Noun.twitter(word, true),
         nil <- Noun.wikipedia_title_noun(word, true),
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
      true -> nil
    end
  end
end
