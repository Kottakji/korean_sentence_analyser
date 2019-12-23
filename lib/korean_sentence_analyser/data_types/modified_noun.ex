defmodule KoreanSentenceAnalyser.DataTypes.ModifiedNoun do
  alias KoreanSentenceAnalyser.DataTypes.Eomi
  alias KoreanSentenceAnalyser.Helpers.Formatter
  alias KoreanSentenceAnalyser.Helpers.Word
  alias KoreanSentenceAnalyser.Helpers.KoreanUnicode
  @data_type "Mix"
  
  def find(word) do
    case Eomi.remove_recursively(word, "data/noun/nouns.txt", @data_type) do
      nil -> nil
      match ->
        remains = Word.get_remaining(word, match)
        
        with nil <- find(word, remains, "ᄒ"),
             nil <- find(word, remains, "ᄃ"),
             do: nil
    end
  end
  
  defp find(word, "히", _) do
    word
    |> Formatter.print_result(@data_type)
  end
  
  defp find(word, remains, "ᄒ") do
    case KoreanUnicode.starts_with?(remains, "ᄒ") do
      true -> word
              |> String.replace(remains, "")
              |> Formatter.add_ending("하다")
              |> Formatter.print_result(@data_type)
      false -> nil
    end
  end
  
  defp find(word, remains, "ᄃ") do
    case KoreanUnicode.starts_with?(remains, "ᄃ") do
      true -> word
              |> String.replace(remains, "")
              |> Formatter.add_ending("되")
              |> Formatter.print_result(@data_type)
      false -> nil
    end
  end

end
