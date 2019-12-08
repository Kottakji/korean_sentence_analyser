defmodule KoreanSentenceAnalyser.DataTypes.Verb do
  import KoreanSentenceAnalyser.DataAnalyser
  @data_type "Verb"

  def verb(word) do
    result =
      case find_verb_non_destructive(word) do
        nil -> find_verb_destructive(word)
        result -> result
      end

    result
    |> add_ending("다")
    |> print_result(@data_type, "Verb")
  end

  defp find_verb_non_destructive(word) do
    word = normalize(word)

    find_in_file("data/verb/verb.txt", word)
  end

  defp find_verb_destructive(word) do
    word = normalize_destructive(word)

    find_in_file("data/verb/verb.txt", word)
  end
end
