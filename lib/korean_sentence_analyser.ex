defmodule KoreanSentenceAnalyser do
  alias KoreanSentenceAnalyser.DataTypes.Modifier
  alias KoreanSentenceAnalyser.Helpers.KoreanUnicode
  alias KoreanSentenceAnalyser.Helpers.SplitWord
  alias KoreanSentenceAnalyser.Helpers.Word

  @moduledoc """
  Analyses Korean text
  Returns their stem/base form and additional information, like whether it's a noun
  """

  def analyse_sentence("") do
    nil
  end

  def analyse_sentence(sentence) do
    KoreanUnicode.split(sentence)
    |> Enum.map(fn x ->
      analyse_word(x)
    end)
    |> Enum.filter(fn x -> x != nil end)
    |> List.flatten()
    |> Enum.uniq()
  end

  def analyse_word("") do
    nil
  end

  def analyse_word(word) do
    with nil <- Word.find(word),
         nil <- Word.find(Modifier.remove(word)),
         nil <- SplitWord.find(word),
         do: nil
  end
end
