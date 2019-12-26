defmodule KoreanSentenceAnalyser do
  alias KoreanSentenceAnalyser.DataTypes.Modifier
  alias KoreanSentenceAnalyser.Helpers.KoreanUnicode
  alias KoreanSentenceAnalyser.Helpers.SplitWord
  alias KoreanSentenceAnalyser.Helpers.Word

  @moduledoc """
  Analyse Korean text
  """

  @doc """
  Analyse a Korean sentence
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

  defp analyse_word("") do
    nil
  end

  defp analyse_word(word) do
    with nil <- Word.find(word),
         nil <- Modifier.find(word), # Outside of Word.find(), because it calls Word.find()
         nil <- Word.find(Modifier.remove(word)),
         nil <- SplitWord.find(word),
         do: nil
  end
end
