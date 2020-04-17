defmodule KoreanSentenceAnalyser do
  @moduledoc """
  An attempt to try to get information about Korean text.

  Given a sentence or word, this library will give a fairly accurate list of words and information about the type of words.
  A type (noun, verb, adjective etc) is returned, as well as a specific type (K-pop, Wikipedia title etc).

  All words are returned in the form they appear in the dictionary: 공부하다, 일하다). Thus this can be useful find a dictionary searchable base of a conjugated word.

  All modules are documented and can be used individually, but keep in mind that they are build mainly for the sentence_analyse function. Feel free to open a issue on github if you have any questions.
  """

  use Application

  @doc false
  def start(_type, _args) do
    KSA.DictFile.init()
    Supervisor.start_link([], strategy: :one_for_one)
  end

  @doc """
  Analyse a Korean sentence

      iex> KoreanSentenceAnalyser.analyse_sentence("한국은 동아시아의 한반도에 위치하고 있다")
      [
        %{"specific_type" => "Noun", "token" => "한국", "type" => "Noun"},
        %{"specific_type" => "Wikipedia title noun","token" => "동아시아","type" => "Noun"},
        %{"specific_type" => "Entities", "token" => "한반도", "type" => "Noun"},
        %{"specific_type" => "Grammar", "token" => "에", "type" => "Grammar"},
        %{"specific_type" => "Noun", "token" => "위치", "type" => "Noun"},
        %{"specific_type" => "Adjective", "token" => "있다", "type" => "Adjective"}
      ]
  """
  def analyse_sentence("") do
    nil
  end

  def analyse_sentence(sentence) do
    sentence
    |> KSA.KoreanUnicode.split()
    |> KSA.Grammar.remove()
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
    with nil <- KSA.Word.find(word),
         # Outside of Word.find(), else it would match too easily
         nil <- KSA.Modifier.find(word),
         # Outside of Word.find(), because it calls Word.find()
         nil <- KSA.Word.find(KSA.Modifier.remove(word)),
         nil <- KSA.SplitWord.find(word),
         do: nil
  end
end
