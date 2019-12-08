defmodule KoreanSentenceAnalyser.DataTypes.Substantive do
  import KoreanSentenceAnalyser.DataAnalyser
  @data_type "Substantive"

  def given_name(word) do
    find_in_file("data/substantives/given_names.txt", word)
    |> print_result(@data_type, "Given name")
  end

  def family_name(word) do
    find_in_file("data/substantives/family_names.txt", word)
    |> print_result(@data_type, "Family name")
  end
end
