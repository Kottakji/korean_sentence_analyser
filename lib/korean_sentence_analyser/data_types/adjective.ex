defmodule KoreanSentenceAnalyser.DataTypes.Adjective do
  import KoreanSentenceAnalyser.DataAnalyser
  @data_type "Adjective"

  def adjective(word) do
    result =
      case find_adjective_non_destructive(word) do
        nil -> find_adjective_destructive(word)
        result -> result
      end

    result
    |> add_ending("다")
    |> print_result(@data_type, "Adjective")
  end

  defp find_adjective_non_destructive(word) do
    word = normalize(word)

    find_in_file("data/adjective/adjective.txt", word)
  end

  defp find_adjective_destructive(word) do
    word = normalize_destructive(word)

    find_in_file("data/adjective/adjective.txt", word)
  end
end
