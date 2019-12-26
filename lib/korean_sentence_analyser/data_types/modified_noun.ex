defmodule KoreanSentenceAnalyser.DataTypes.ModifiedNoun do
  alias KoreanSentenceAnalyser.DataTypes.Eomi
  alias KoreanSentenceAnalyser.Helpers.Formatter
  alias KoreanSentenceAnalyser.Helpers.Word
  alias KoreanSentenceAnalyser.Helpers.Stem
  alias KoreanSentenceAnalyser.Helpers.KoreanUnicode
  alias KoreanSentenceAnalyser.Helpers.Dict
  @data_type "Mix"
  
  @doc """
  Find the word when it's a verb of adjective based on a noun
  For example 생각하다 from 생각
  """
  def find(word) do
    find(word, word)
  end
  
  defp find(nil, _) do
    nil
  end

  defp find("", _) do
    nil
  end
  
  defp find(word, original_word) do
    case Dict.find_in_file(word, "data/noun/nouns.txt") do
      nil ->
        case Eomi.remove(word) do
          new_word when new_word != word ->
            find(new_word, word)
          no_match ->
            find_as_last_resort(Stem.stem(no_match))
        end
      match ->
        remains = Word.get_remaining(original_word, match)
        
        with nil <- add_ending(match, remains, "ᄒ"),
             nil <- add_ending(match, remains, "ᄃ"),
             do: nil
    end
  end
  
  defp find_as_last_resort(nil) do
    nil
  end
  
  defp find_as_last_resort(stem) do
    case String.last(stem) do
      "하" ->
        Word.get_remaining(stem, "하")
        |> Dict.find_in_file("data/noun/nouns.txt")
        |> Formatter.add_ending("하다")
        |> Formatter.print_result(@data_type)
      "되" ->
        Word.get_remaining(stem, "되")
        |> Dict.find_in_file("data/noun/nouns.txt")
        |> Formatter.add_ending("하다")
        |> Formatter.print_result(@data_type)
      _ -> nil
    end
  end

  defp add_ending(word, "히", _) do
    word
    |> Formatter.add_ending("히")
    |> Formatter.print_result(@data_type)
  end

  defp add_ending(word, remains, "ᄒ") do
    case KoreanUnicode.starts_with?(remains, "ᄒ") do
      true -> word
              |> String.replace(remains, "")
              |> Formatter.add_ending("하다")
              |> Formatter.print_result(@data_type)
      false -> nil
    end
  end
  
  defp add_ending(word, remains, "ᄃ") do
    case KoreanUnicode.starts_with?(remains, "ᄃ") do
      true -> word
              |> String.replace(remains, "")
              |> Formatter.add_ending("되")
              |> Formatter.print_result(@data_type)
      false -> nil
    end
  end

end