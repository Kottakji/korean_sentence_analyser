defmodule Verb do
  @moduledoc false
  
  alias Eomi
  alias Formatter
  alias KoreanUnicode
  alias LocalDict
  alias Stem
  alias Word
  
  @data_type "Verb"
  @file_path "data/verb/verb.txt"
  
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
  
  defp find("입니가", _) do
    "입니"
  end
  
  defp find("입니다", _) do
    "입니"
  end
  
  defp find(word, file) do
    case LocalDict.find_in_file(word, file) do
      nil ->
        case Eomi.remove(word) do
          new_word when new_word != word ->
            find(new_word, file)
          
          _ ->
            word
            |> Stem.find()
            |> LocalDict.find_in_file(file)
        end
      
      match ->
        match
    end
  end
  
  @doc """
  Removes certain verb patterns that otherwise wouldn't match
  For example: 할 수 있다, should not match on 하다, 수 and 있다, but only on 하다
  """
  def remove_verb_patterns(list) when is_list(list) do
    list
    |> remove_verb_patterns(Enum.find_index(list, fn x -> x == "수" end), Enum.count(list) - 1)
  end
  
  defp remove_verb_patterns(list, nil, _) do
    list
  end
  
  defp remove_verb_patterns(list, 0, _) do
    list
  end
  
  defp remove_verb_patterns(list, index, total) when index == total do
    list
  end
  
  defp remove_verb_patterns(list, index, _total) do
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
end
