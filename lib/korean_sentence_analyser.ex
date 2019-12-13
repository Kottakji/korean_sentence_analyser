defmodule KoreanSentenceAnalyser do
  alias KoreanSentenceAnalyser.DataTypes.Substantive
  alias KoreanSentenceAnalyser.DataTypes.Noun
  alias KoreanSentenceAnalyser.DataTypes.Adverb
  alias KoreanSentenceAnalyser.DataTypes.Adjective
  alias KoreanSentenceAnalyser.DataTypes.Verb
  alias KoreanSentenceAnalyser.DataTypes.Conjunction
  alias KoreanSentenceAnalyser.KoreanUnicode
  
  @moduledoc """
  Analyses Korean text
  Returns their stem/base form and additional information, like whether it's a noun
  """
  
  def analyse_sentence("") do
    nil
  end
  
  def analyse_sentence(sentence) do
    KoreanUnicode.split(sentence)
    |> Enum.map(
         fn x ->
           analyse_word(x)
         end
       )
  end
  
  
  def analyse_word("") do
    nil
  end
  
  def analyse_word(word) do
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
         do: %{}
  end
end
