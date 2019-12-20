defmodule KoreanSentenceAnalyser.DataTypes.Verb do
  alias KoreanSentenceAnalyser.DataAnalyser
  alias KoreanSentenceAnalyser.Helpers.Formatter
  @data_type "Verb"

  def verb(word) do
    DataAnalyser.remove_eomi_recursively(word, "data/verb/verb.txt", @data_type)
    |> Formatter.add_ending("다")
    |> Formatter.print_result(@data_type)
  end
end
