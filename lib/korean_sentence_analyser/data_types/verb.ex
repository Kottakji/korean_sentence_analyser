defmodule KoreanSentenceAnalyser.DataTypes.Verb do
  alias KoreanSentenceAnalyser.DataTypes.Eomi
  alias KoreanSentenceAnalyser.Helpers.Formatter
  alias KoreanSentenceAnalyser.Helpers.Dict
  alias KoreanSentenceAnalyser.Helpers.Stem
  @data_type "Verb"
  @file_path  "data/verb/verb.txt"
  
  @doc """
  Find if the word is a verb
  """
  def find(word) do
    word
    |> find(@file_path)
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
            word
            |> Stem.find
            |> Dict.find_in_file(file)
        end
      match ->
        match
    end
  end
end
