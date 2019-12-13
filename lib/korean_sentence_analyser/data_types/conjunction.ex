defmodule KoreanSentenceAnalyser.DataTypes.Conjunction do
  import KoreanSentenceAnalyser.DataAnalyser
  @data_type "Conjunction"

  def conjunction(word) do
    find_in_file("data/auxiliary/conjunctions.txt", word)
    |> print_result(@data_type, "Conjunction")
  end
end
