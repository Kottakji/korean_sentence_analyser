defmodule KoreanSentenceAnalyser.Helpers.Dict do
  @moduledoc """
  Use our local dictionary to see if words exist
  """
  
  alias KoreanSentenceAnalyser.DataTypes.Josa

  @doc """
  Find a word in a file
  """
  def find_in_file(word, file) do
    result =
      File.read!(file)
      |> String.split("\n")
      |> Enum.find(fn x -> x == word end)

    case result do
      "" -> nil
      match -> match
    end
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
  Find the ending of a word in a file
  """
  def find_ending_in_file(word, file) do
    result =
      File.read!(file)
      |> String.split("\n")
      |> Enum.sort(&(String.length(&1) >= String.length(&2)))
      |> Enum.find(fn x -> Regex.match?(Regex.compile!(x <> "$", "u"), word) end)

    case result do
      "" -> nil
      match -> match
    end
  end

  @doc """
  Find the beginning of a word in a file
  """
  def find_beginning_in_file(word, file) do
    result =
      File.read!(file)
      |> String.split("\n")
      |> Enum.sort(&(String.length(&1) >= String.length(&2)))
      |> Enum.find(fn x -> Regex.match?(Regex.compile!("^" <> x, "u"), word) end)

    case result do
      "" -> nil
      match -> match
    end
  end
end
