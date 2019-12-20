defmodule KoreanSentenceAnalyser.Helpers.Dict do
  @moduledoc """
  Use our local dictionary to see if words exist
  """

  @doc """
  Find a word in a file
  """
  def find_in_file(word, file) do
    File.read!(file)
    |> String.split("\n")
    |> Enum.find(fn x -> x == word end)
  end

  @doc """
  Find the ending of a word in a file
  """
  def find_ending_in_file(word, file) do
    File.read!(file)
    |> String.split("\n")
    |> Enum.sort(&(String.length(&1) >= String.length(&2)))
    |> Enum.find(fn x -> Regex.match?(Regex.compile!(x <> "$", "u"), word) end)
  end

  @doc """
  Find the beginning of a word in a file
  """
  def find_beginning_in_file(word, file) do
    File.read!(file)
    |> String.split("\n")
    |> Enum.sort(&(String.length(&1) >= String.length(&2)))
    |> Enum.find(fn x -> Regex.match?(Regex.compile!("^" <> x, "u"), word) end)
  end
end
