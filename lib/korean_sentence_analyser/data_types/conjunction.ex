defmodule KoreanSentenceAnalyser.DataTypes.Conjunction do
  alias KoreanSentenceAnalyser.Helpers.Dict
  alias KoreanSentenceAnalyser.Helpers.Formatter
  @data_type "Conjunction"
  
  def conjunction(word) do
    word
    |> Dict.find_in_file("data/auxiliary/conjunctions.txt")
    |> Formatter.print_result(@data_type, "Conjunction")
  end
end
