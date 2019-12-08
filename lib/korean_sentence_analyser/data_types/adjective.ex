defmodule KoreanSentenceAnalyser.DataTypes.Adjective do
  import KoreanSentenceAnalyser.DataAnalyser
  @data_type "Adjective"

  def adjective(word) do
    word = normalize(word)

    find_in_file("data/adjective/adjective.txt", word)
    |> add_ending("다")
    |> print_result(@data_type, "Adjective")
  end
end
