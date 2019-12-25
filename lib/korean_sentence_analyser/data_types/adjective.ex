defmodule KoreanSentenceAnalyser.DataTypes.Adjective do
  alias KoreanSentenceAnalyser.DataTypes.Eomi
  alias KoreanSentenceAnalyser.Helpers.Dict
  alias KoreanSentenceAnalyser.Helpers.Formatter
  @data_type "Adjective"
  
  def find(word) do
    word
    |> find("data/adjective/adjective.txt")
    |> Formatter.add_ending("다")
    |> Formatter.print_result(@data_type)
  end
  
  defp find(nil, _) do
    nil
  end
  
  defp find("", _) do
    nil
  end
  
  defp find(word, file) do
    case Dict.find_in_file(word, file) do
      nil ->
        case Eomi.remove(word) do
          new_word when new_word != word ->
            find(new_word, file)
          _ ->
            with nil <- Dict.find_in_file(word, file),
                 nil <- Dict.find_in_file(word <> "하", file),
                 do: nil
        end
      match ->
        match
    end
  end
end
