defmodule KoreanSentenceAnalyser.DataTypes.Adverb do
  alias KoreanSentenceAnalyser.Helpers.Dict
  alias KoreanSentenceAnalyser.Helpers.Formatter
  @data_type "Adverb"

  def adverb(word) do
    word
    |> Dict.find_in_file("data/adverb/adverb.txt")
    |> Formatter.print_result(@data_type, "Adverb")
  end
end
