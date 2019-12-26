defmodule KoreanSentenceAnalyser do
  @moduledoc """
  Analyse Korean text
  """

  use Application
  alias KoreanSentenceAnalyser.DataTypes.Modifier
  alias KoreanSentenceAnalyser.Helpers.KoreanUnicode
  alias KoreanSentenceAnalyser.Helpers.SplitWord
  alias KoreanSentenceAnalyser.Helpers.Word
  alias KoreanSentenceAnalyser.ETS.DictFile

  def start(_type, _args) do
    DictFile.init()
    Supervisor.start_link([], strategy: :one_for_one)
  end

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
         # Outside of Word.find(), because it calls Word.find()
         nil <- Modifier.find(word),
         nil <- Word.find(Modifier.remove(word)),
         nil <- SplitWord.find(word),
         do: nil
  end
end
