defmodule KoreanSentenceAnalyser.Helpers.Dict do
  @moduledoc """
  Use our local dictionary to see if words exist
  """

  alias KoreanSentenceAnalyser.Helpers.Word
  alias KoreanSentenceAnalyser.ETS.DictFile
  alias KoreanSentenceAnalyser.DataTypes.Josa

  @doc """
  Find a word in a file
  """
  def find_in_file(word, file) do
    DictFile.find(word, file)
  end

  @doc """
  Find a word in a file, and does not remove the josa
  """
  def find_in_file(word, file, false) do
    find_in_file(word, file)
  end

  @doc """
  Find a word in a file, but removes the josa
  """
  def find_in_file(word, file, true) do
    find_in_file(Josa.remove(word), file)
  end

  @doc """
  Finds the biggest word from the beginning of the word in the file
  It does this going of the words in a dictionary file, that are ordered by length DESC
  If the dictionary word matches at the start of the search word, it's a match
  Because it's ordered, it will always find the biggest word at the start
  For example:
  Search on 한국대사관 will match 한국 (the biggest word from the start)
  """
  def find_beginning_in_file("", _file) do
    nil
  end

  def find_beginning_in_file(word, file) do
    case DictFile.find(word, file) do
      nil -> find_beginning_in_file(String.slice(word, 0..-2), file)
      match -> match
    end
  end

  @doc """
  Finds the biggest word from the ending of the word in the file
  It does this going of the words in a dictionary file, that are ordered by length DESC
  If the dictionary word matches at the end of the search word, it's a match
  Because it's ordered, it will always find the biggest word at the end
  For example:
  Search on 한국대사관 will match 대사관 (the biggest word from the end)
  """
  def find_ending_in_file("", _file) do
    nil
  end

  def find_ending_in_file(word, file) do
    case DictFile.find(word, file) do
      nil -> find_ending_in_file(String.slice(word, 1..-1), file)
      match -> match
    end
  end

  @doc """
  Finds the smallest word from the ending of the word in the file
  It does this going of the words in a dictionary file, that are ordered by length DESC
  If the dictionary word matches at the end of the search word, it's a match
  For example:
  Search on 한국 will match 국 (the smallest word from the end)
  """
  def find_smallest_ending_in_file("", _file) do
    nil
  end

  def find_smallest_ending_in_file(word, file) do
    find_smallest_ending_in_file(String.last(word), word, file)
  end

  defp find_smallest_ending_in_file("", _original_word, _file) do
    nil
  end

  defp find_smallest_ending_in_file(word, original_word, file) when byte_size(word) == 3 or byte_size(original_word) == 3 do
    DictFile.find(word, file)
  end

  defp find_smallest_ending_in_file(word, original_word, file) do
    case DictFile.find(word, file) do
      nil ->
        original_word
        |> Word.get_remaining(word)
        |> String.last()
        |> find_smallest_ending_in_file(original_word, file)

      match ->
        match
    end
  end
end
