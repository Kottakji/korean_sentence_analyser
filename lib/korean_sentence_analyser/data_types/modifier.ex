defmodule KSA.Modifier do
  @moduledoc """
  A modifier changes, clarifies, qualifies, or limits a particular word in a sentence in order to add emphasis, explanation, or detail.

  For example in 한표 (one ticket), 한 is the modifier, 표 is the noun
  """

  @data_type "Modifier"
  @file_path "substantives/modifier.txt"

  @doc """
  Find if the word is a modifier

      iex> KSA.Modifier.find("세개")
      [
        %{"specific_type" => "Modifier", "token" => "세", "type" => "Modifier"},
        %{"specific_type" => "Noun", "token" => "개", "type" => "Noun"}
      ]

  """
  def find(word) do
    word =
      word
      |> KSA.KoreanUnicode.split()
      |> List.to_string()

    with nil <- find_at_beginning(word),
         nil <- find_at_ending(word),
         nil <- find_as_whole(word),
         do: nil
  end

  @doc """
  Remove the modifier from a word
  """
  def remove(word) do
    case KSA.LocalDict.find_beginning_in_file(word, @file_path) do
      nil ->
        # Just return the original word
        word

      match ->
        # Return the remaining word
        KSA.Word.get_remaining(word, match)
    end
  end

  defp find_at_beginning(word) do
    with modifier_match when not is_nil(modifier_match) <- KSA.LocalDict.find_beginning_in_file(word, @file_path),
         remaining when not is_nil(remaining) <- KSA.Word.get_remaining(word, modifier_match),
         remaining_match when not is_nil(remaining_match) <- KSA.Word.find(remaining),
         do: [
           KSA.Formatter.print_result(modifier_match, @data_type),
           remaining_match
         ]
  end

  defp find_at_ending(word) do
    with modifier_match when not is_nil(modifier_match) <- KSA.LocalDict.find_ending_in_file(word, @file_path),
         remaining when not is_nil(remaining) <- KSA.Word.get_remaining(word, modifier_match),
         remaining_match when not is_nil(remaining_match) <- KSA.Word.find(remaining),
         do: [
           remaining_match,
           KSA.Formatter.print_result(modifier_match, @data_type)
         ]
  end

  defp find_as_whole(word) do
    word
    |> KSA.LocalDict.find_in_file(@file_path)
    |> KSA.Formatter.print_result(@data_type)
  end
end
