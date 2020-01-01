defmodule KSA.Adjective do
  @moduledoc false

  @data_type "Adjective"
  @file_path "adjective/adjective.txt"

  @doc """
  Find if the word is an adjective
    
      iex> KSA.Adjective.find("힘들")
      %{"specific_type" => "Adjective", "token" => "힘들다", "type" => "Adjective"}
  """
  def find(word) do
    find(word, word)
    |> KSA.Formatter.add_ending("다")
    |> KSA.Formatter.print_result(@data_type)
  end

  defp find(nil, _) do
    nil
  end

  defp find("", _) do
    nil
  end

  defp find(word, original_word) do
    with nil <- KSA.LocalDict.find_in_file(word, @file_path),
         nil <- find_with_changing_final_consonant(original_word),
         nil <- find_with_removing_da(word, original_word),
         nil <- find_with_removing_eomi(word, original_word),
         do: nil
  end

  defp find_with_changing_final_consonant(nil) do
    nil
  end

  defp find_with_changing_final_consonant(word) do
    case KSA.KoreanUnicode.get_final_consonant(String.last(word)) == "ᆫ" do
      true ->
        word
        |> KSA.KoreanUnicode.change_final_consonant("ᇂ")
        |> KSA.LocalDict.find_in_file(@file_path)

      false ->
        nil
    end
  end

  defp find_with_removing_da(word, original_word) when byte_size(word) > 3 do
    case String.last(word) do
      "다" -> KSA.LocalDict.find_in_file(KSA.Word.get_remaining(word, "다"), @file_path)
      _ -> find_with_removing_eomi(word, original_word)
    end
  end

  defp find_with_removing_da(_, _) do
    nil
  end

  defp find_with_removing_eomi(word, original_word) do
    case KSA.Eomi.remove(word) do
      new_word when new_word != word ->
        case KSA.LocalDict.find_in_file(word, "verb/verb.txt") do
          nil -> find(new_word, original_word)
          _match -> nil # Do not find when we have a matching verb
        end
      _ ->
        case KSA.LocalDict.find_in_file(word, @file_path) do
          nil ->
            with remains when remains != nil <- KSA.Word.get_remaining(original_word, word),
                 last when last != nil <- String.last(remains),
                 true <- KSA.KoreanUnicode.starts_with?(last, "ᄒ") do
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
