defmodule KoreanSentenceAnalyser.DataTypes.Conjunction do
  import KoreanSentenceAnalyser.DataAnalyser
  @data_type "Conjunction"
  
  def conjunction(word) do
    word
    |> find_in_file("data/auxiliary/conjunctions.txt")
    |> print_result(@data_type, "Conjunction")
  end
end
