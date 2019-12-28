defmodule VerbPattern do
  @moduledoc """
  There are certain verb patterns that do not get matched by our other modules
  """
  
  alias Word
  alias KoreanUnicode
  
  @doc """
  Remove certain verb patterns that otherwise wouldn't match
  
      iex> VerbPattern.remove(["마실", "수", "있다"])
      ["마시"]
  """
  def remove(list) when is_list(list) do
    list
    |> halsuisdda(Enum.find_index(list, fn x -> x == "수" end), Enum.count(list) - 1)
    |> eunda()
  end
  
  defp halsuisdda(list, nil, _) do
    list
  end
  
  defp halsuisdda(list, 0, _) do
    list
  end
  
  defp halsuisdda(list, index, total) when index == total do
    list
  end
  
  defp halsuisdda(list, index, _total) do
    starts_with_rieul = list
                        |> Enum.at(index - 1)
                        |> String.last()
                        |> KoreanUnicode.ends_with_final?("ᆯ")
    
    ends_with_issda_or_obtda = list
                               |> Enum.at(index + 1)
                               |> String.first()
                               |> String.contains?(["있", "없"])
    
    case starts_with_rieul == true && ends_with_issda_or_obtda == true do
      true ->
        new_value = list
                    |> Enum.at(index - 1)
                    |> remove_rieul()
        
        list
        |> List.delete_at(index + 1)
        |> List.delete_at(index)
        |> List.replace_at(index - 1, new_value)
      false -> list
    end
  end
  
  defp remove_rieul(word) when byte_size(word) > 3 do
    last = String.last(word)
    remains = Word.get_remaining(word, last)
    remains <> remove_rieul(last)
  end
  
  defp remove_rieul("을") do
    ""
  end
  
  defp remove_rieul(character) do
    KoreanUnicode.remove_final_consonant(character)
  end
  
  defp eunda(list) when is_list(list) do
    list
    |> Enum.map(fn x -> eunda(x) end)
  end
  
  defp eunda(word) when byte_size(word) >= 6 do
    last = String.slice(word, -2..-1)
    remains = Word.get_remaining(word, last)
    case last do
      "한다" -> remains <> "하다"
      _ -> word
    end
  end
  
  defp eunda(word) do
    word
  end
end
