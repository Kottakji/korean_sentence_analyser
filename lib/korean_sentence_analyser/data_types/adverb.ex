defmodule KoreanSentenceAnalyser.DataTypes.Adverb do
  import KoreanSentenceAnalyser.DataAnalyser
  @data_type "Adverb"

  def adverb(word) do
    word
    |> find_in_file("data/adverb/adverb.txt")
    |> print_result(@data_type, "Adverb")
  end
end
