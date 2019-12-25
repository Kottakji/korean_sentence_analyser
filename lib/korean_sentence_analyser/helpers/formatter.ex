defmodule KoreanSentenceAnalyser.Helpers.Formatter do
  @moduledoc """
  Formats the data
  """

  @doc """
  Add an ending to a word
  In case no word is found, we return nil
  """
  def add_ending(word, ending) do
    case word do
      nil -> nil
      "" -> nil
      word ->
        word <> ending
    end
  end

  @doc """
  Print the result in token format
  Or nil if nothing is found
  """
  def print_result(value, type, specific_type) do
    case value do
      nil -> nil
      value -> %{"token" => value, "type" => type, "specific_type" => specific_type}
    end
  end

  def print_result(value, type) do
    print_result(value, type, type)
  end
end
