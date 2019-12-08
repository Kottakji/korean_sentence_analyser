defmodule KoreanSentenceAnalyser.DataAnalyser do
  alias KoreanSentenceAnalyser.Normalize

  def normalize(word) do
    Normalize.normalize(word)
  end

  def find_in_file(file, word) do
    File.read!(file)
    |> String.split("\n")
    |> Enum.find(fn x -> x == word end)
  end
  
  def add_ending(word, ending) do
    case word do
      nil -> nil
      word -> word <> ending
    end
  end
  
  def print_result(value, type, specific_type) do
    case value do
      nil -> nil
      value -> %{"token" => value, "type" => type, "specific_type" => specific_type}
    end
  end
end
