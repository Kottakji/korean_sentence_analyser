defmodule KoreanSentenceAnalyser.DataTypes.Substantive do
  alias KoreanSentenceAnalyser.Helpers.Dict
  alias KoreanSentenceAnalyser.Helpers.Formatter
  @data_type "Substantive"

  def given_name(word) do
    word
    |> Dict.find_in_file("data/substantives/given_names.txt")
    |> Formatter.print_result(@data_type, "Given name")
  end

  def family_name(word) do
    word
    |> Dict.find_in_file("data/substantives/family_names.txt")
    |> Formatter.print_result(@data_type, "Family name")
  end
end
