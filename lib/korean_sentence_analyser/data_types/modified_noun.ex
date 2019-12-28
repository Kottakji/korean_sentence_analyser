defmodule ModifiedNoun do
  @moduledoc """
  A modified noun is a verb or an adjective that is based on a noun.
  
  생각 is a noun, but 생각하다 is a verb.
  
  은근 is a noun, but 은근하다 is an adjective.
  """

  alias Eomi
  alias Formatter
  alias Word
  alias Stem
  alias KoreanUnicode
  alias LocalDict
  
  @data_type "Mix"
  @file_path "data/noun/nouns.txt"

  @doc """
  Find if the word is a modified noun
  
      iex> ModifiedNoun.find("생각한다면")
      %{"specific_type" => "Mix", "token" => "생각하다", "type" => "Mix"}
    
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
    case LocalDict.find_in_file(word, @file_path) do
      nil ->
        case Eomi.remove(word) do
          new_word when new_word != word ->
            find(new_word, word)

          no_match ->
            find_as_last_resort(Stem.find(no_match))
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
        |> LocalDict.find_in_file(@file_path)
        |> Formatter.add_ending("하다")
        |> Formatter.print_result(@data_type)

      "되" ->
        Word.get_remaining(stem, "되")
        |> LocalDict.find_in_file(@file_path)
        |> Formatter.add_ending("하다")
        |> Formatter.print_result(@data_type)

      _ ->
        nil
    end
  end

  defp add_ending(word, "히", _) do
    word
    |> Formatter.add_ending("히")
    |> Formatter.print_result(@data_type)
  end

  defp add_ending(word, remains, "ᄒ") do
    case KoreanUnicode.starts_with?(remains, "ᄒ") do
      true ->
        word
        |> String.replace(remains, "")
        |> Formatter.add_ending("하다")
        |> Formatter.print_result(@data_type)

      false ->
        nil
    end
  end

  defp add_ending(word, remains, "ᄃ") do
    case KoreanUnicode.starts_with?(remains, "ᄃ") do
      true ->
        word
        |> String.replace(remains, "")
        |> Formatter.add_ending("되")
        |> Formatter.print_result(@data_type)

      false ->
        nil
    end
  end
end
