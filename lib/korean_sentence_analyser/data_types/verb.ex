defmodule KoreanSentenceAnalyser.DataTypes.Verb do
  alias KoreanSentenceAnalyser.DataTypes.Eomi
  alias KoreanSentenceAnalyser.Helpers.Formatter
  @data_type "Verb"

  def verb(word) do
    Eomi.remove_recursively(word, "data/verb/verb.txt", @data_type)
    |> Formatter.add_ending("다")
    |> Formatter.print_result(@data_type)
  end
end
