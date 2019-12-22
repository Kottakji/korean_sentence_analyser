defmodule KoreanSentenceAnalyser.DataTypes.Modifier do
  alias KoreanSentenceAnalyser.Helpers.Dict
  alias KoreanSentenceAnalyser.Helpers.Formatter
  alias KoreanSentenceAnalyser.Helpers.Word
  alias KoreanSentenceAnalyser.Helpers.KoreanUnicode
  @data_type "Modifier"

  @doc """
  Finds the word when it contains a modifier
  """
  def find(word) do
    word =
      word
      |> KoreanUnicode.split()
      |> List.to_string()

      with nil <- find_at_beginning(word),
           nil <- find_at_ending(word),
           nil <- find_as_whole(word),
           do: nil
  end

  defp find_at_beginning(word) do
    with modifier_match when not is_nil(modifier_match) <- Dict.find_beginning_in_file(word, "data/substantives/modifier.txt"),
         remaining when not is_nil(remaining) <- get_remaining_word_remove_from_beginning(word, modifier_match),
         remaining_match when not is_nil(remaining_match) <- Word.find(remaining),
         do: [
           Formatter.print_result(modifier_match, @data_type),
           remaining_match
         ]
  end

  defp find_at_ending(word) do
    with modifier_match when not is_nil(modifier_match) <- Dict.find_ending_in_file(word, "data/substantives/modifier.txt"),
         remaining when not is_nil(remaining) <- get_remaining_word_remove_from_ending(word, modifier_match),
         remaining_match when not is_nil(remaining_match) <- Word.find(remaining),
         do: [
           remaining_match,
           Formatter.print_result(modifier_match, @data_type)
         ]
  end

  defp find_as_whole(word) do
    word
    |> Dict.find_in_file("data/substantives/modifier.txt")
    |> Formatter.print_result(@data_type)
  end

  @doc """
  Remove the modifier from a word
  Can be useful when you still want to find a single meaning of 한표 for example, it should be 표, and not nothing

  Returns the word when nothing is found
  """
  def remove(word) do
    case Dict.find_beginning_in_file(word, "data/substantives/modifier.txt") do
      nil ->
        # Just return the original word
        word

      match ->
        # Return the remaining word
        get_remaining_word_remove_from_beginning(word, match)
    end
  end

  defp get_remaining_word_remove_from_beginning(word, match) do
    case Regex.replace(Regex.compile!("^" <> match, "u"), word, "") do
      "" -> nil
      string -> string
    end
  end

  defp get_remaining_word_remove_from_ending(word, match) do
    case Regex.replace(Regex.compile!(match <> "$", "u"), word, "") do
      "" -> nil
      string -> string
    end
  end
end
