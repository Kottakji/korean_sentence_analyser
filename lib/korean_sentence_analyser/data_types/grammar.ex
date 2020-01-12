defmodule KSA.Grammar do
  @moduledoc """
  Matches words that remove certain grammar that can be added to the end of words 음으로, 까지, 부터 etc
  Also removes certain grammar words like 중 (during), 내 (inside)
  """

  @data_type "Grammar"
  @file_path "grammar/grammar.txt"

  @doc """
  Find a word when it has a Grammar ending

      iex> KSA.Grammar.find("지역내")
      [
        %{
          "specific_type" => "Noun",
          "token" => "지역",
          "type" => "Noun"
        },
        %{
          "specific_type" => "Grammar",
          "token" => "내",
          "type" => "Grammar"
        }
      ]

  """
  def find(word) do
    case KSA.LocalDict.find_ending_in_file(word, @file_path) do
      nil -> nil
      match -> find(word, match)
    end
  end

  defp find(word, match) do
    remains = KSA.Word.get_remaining(word, match)

    case KSA.Word.find(remains) do
      nil ->
        nil

      remains_match ->
        [
          remains_match,
          KSA.Formatter.print_result(match, @data_type)
        ]
    end
  end

  @doc """
  Remove certain verb patterns that otherwise wouldn't match

      iex> KSA.Grammar.remove(["마실", "수", "있다"])
      ["마시"]
    
      iex> KSA.Grammar.remove(["마실", "수도", "있다"])
      ["마시"]
  """
  def remove(list) when is_list(list) do
    list
    |> halsuisdda(Enum.find_index(list, fn x -> x == "수" end), Enum.count(list) - 1)
    |> halsuisdda(Enum.find_index(list, fn x -> x == "수도" end), Enum.count(list) - 1)
    |> modify_end()
    |> formal_speech()
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
    starts_with_rieul =
      list
      |> Enum.at(index - 1)
      |> String.last()
      |> KSA.KoreanUnicode.ends_with_final?("ᆯ")

    ends_with_issda_or_obtda =
      list
      |> Enum.at(index + 1)
      |> String.first()
      |> String.contains?(["있", "없"])

    case starts_with_rieul == true && ends_with_issda_or_obtda == true do
      true ->
        new_value =
          list
          |> Enum.at(index - 1)
          |> remove_rieul()

        list
        |> List.delete_at(index + 1)
        |> List.delete_at(index)
        |> List.replace_at(index - 1, new_value)

      false ->
        list
    end
  end

  defp remove_rieul(word) when byte_size(word) > 3 do
    last = String.last(word)
    remains = KSA.Word.get_remaining(word, last)
    remains <> remove_rieul(last)
  end

  defp remove_rieul("을") do
    ""
  end

  defp remove_rieul(character) do
    KSA.KoreanUnicode.remove_final_consonant(character)
  end

  defp modify_end(list) when is_list(list) do
    list
    |> Enum.map(fn x -> modify_end(x) end)
  end

  defp modify_end(word) when byte_size(word) >= 6 do
    last = String.slice(word, -2..-1)
    remains = KSA.Word.get_remaining(word, last)

    case last do
      "한다" -> remains <> "하"
      "된다" -> remains <> "되"
      "해서" -> remains <> "하"
      _ -> word
    end
  end

  defp modify_end(word) do
    word
  end

  defp formal_speech(list) when is_list(list) do
    list
    |> Enum.map(fn x -> formal_speech(x) end)
  end

  defp formal_speech(word) do
    list = String.split(word, "니")

    case length(list) do
      2 ->
        [head | _rest] = list

        cond do
          String.last(head) == "습" ->
            KSA.Word.get_remaining(head, "습")

          KSA.KoreanUnicode.ends_with_final?(String.last(head), "ᆸ") ->
            String.slice(head, 0..-2) <> KSA.KoreanUnicode.remove_final_consonant(String.last(head)) <> "다"

          true ->
            word
        end

      _ ->
        word
    end
  end
end
