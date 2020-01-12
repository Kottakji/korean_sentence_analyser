defmodule KSA.Verb do
  @moduledoc false

  @data_type "Verb"
  @file_path "verb/verb.txt"

  @doc """
  Find if the word is a verb

      iex> KSA.Verb.find("먹다")
      %{"specific_type" => "Verb", "token" => "먹다", "type" => "Verb"}
    
  """
  def find(word) do
    result =
      word
      |> find_conjugated()
      |> KSA.Formatter.add_ending("다")
      |> KSA.Formatter.print_result(@data_type)

    cond do
      result == nil ->
        word
        |> find(@file_path)
        |> KSA.Formatter.add_ending("다")
        |> KSA.Formatter.print_result(@data_type)

      true ->
        result
    end
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

  defp find(word, file) when is_binary(word) do
    case KSA.LocalDict.find_in_file(word, file) do
      nil ->
        case KSA.Eomi.remove(word) do
          new_word when new_word != word ->
            find(new_word, file)

          _ ->
            word
            |> KSA.Stem.find()
            |> KSA.LocalDict.find_in_file(file)
        end

      match ->
        match
    end
  end

  defp find_conjugated(word) when byte_size(word) > 3 do
    case String.last(word) do
      # "만드는 -> 만들
      "는" ->
        KSA.Word.get_remaining(word, "는")
        |> KSA.KoreanUnicode.change_final_consonant("ᆯ")
        |> find(@file_path)

      _ ->
        # "만든 -> 만들
        case KSA.KoreanUnicode.ends_with_final?(String.last(word), "ᆫ") do
          true ->
            word
            |> KSA.KoreanUnicode.change_final_consonant("ᆯ")
            |> find(@file_path)

          false ->
            nil
        end
    end
  end

  defp find_conjugated(_) do
    nil
  end
end
