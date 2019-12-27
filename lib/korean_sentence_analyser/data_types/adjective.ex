defmodule KoreanSentenceAnalyser.DataTypes.Adjective do
  @moduledoc false
  
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
    
    with nil <- Dict.find_in_file(word, @file_path),
         nil <- find_with_changing_final_consonant(original_word),
         nil <- find_with_removing_da(word, original_word),
         nil <- find_with_removing_eomi(word, original_word),
         do: nil
  end
  
  defp find_with_changing_final_consonant(nil) do
    nil
  end
  
  defp find_with_changing_final_consonant(word) do
    case KoreanUnicode.get_final_consonant(String.last(word)) == "ᆫ" do
      true ->
        word
        |> KoreanUnicode.change_final_consonant("ᇂ")
        |> Dict.find_in_file(@file_path)
      false -> nil
    end
  end
  
  defp find_with_removing_da(word, original_word) when byte_size(word) > 3 do
    case String.last(word) do
      "다" -> Dict.find_in_file(Word.get_remaining(word, "다"), @file_path)
      _ -> find_with_removing_eomi(word, original_word)
    end
  end
  
  defp find_with_removing_da(_, _) do
    nil
  end
  
  defp find_with_removing_eomi(word, original_word) do
    case Eomi.remove(word) do
      new_word when new_word != word ->
        find(new_word, original_word)
      
      _ ->
        case Dict.find_in_file(word, @file_path) do
          nil ->
            with remains when remains != nil <- Word.get_remaining(original_word, word),
                 last when last != nil <- String.last(remains),
                 true <- KoreanUnicode.starts_with?(last, "ᄒ") do
              find(word <> "하", word)
            else
              _ -> nil
            end
          
          match ->
            match
        end
    end
  end
end
