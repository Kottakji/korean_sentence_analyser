defmodule KoreanSentenceAnalyser.DataTypes.Adjective do
  alias KoreanSentenceAnalyser.DataTypes.Eomi
  alias KoreanSentenceAnalyser.Helpers.Dict
  alias KoreanSentenceAnalyser.Helpers.Formatter
  alias KoreanSentenceAnalyser.Helpers.KoreanUnicode
  alias KoreanSentenceAnalyser.Helpers.Word
  @data_type "Adjective"
  @file_path "data/adjective/adjective.txt"

  @doc """
  Find if the word is an adjective
  """
  def find(word) do
    find(word, word)
    |> Formatter.add_ending("다")
    |> Formatter.print_result(@data_type)
  end

  defp find(nil, _) do
    nil
  end

  defp find("", _) do
    nil
  end

  defp find(word, original_word) do
    case Dict.find_in_file(word, @file_path) do
      nil ->
        case Eomi.remove(word) do
          new_word when new_word != word ->
            find(new_word, original_word)

          _ ->
            case Dict.find_in_file(word, @file_path) do
              nil ->
                case original_word
                     |> Word.get_remaining(word)
                     |> KoreanUnicode.starts_with?("ᄒ") do
                  false -> nil
                  true -> find(word <> "하", word)
                end

              match ->
                match
            end
        end

      match ->
        match
    end
  end
end
