defmodule KoreanSentenceAnalyser.DataAnalyser do
  alias KoreanSentenceAnalyser.Normalize

  @doc """
  Normalizes a verb/adjective
  Turn 해요 into 하 etc
  """
  def normalize(word) do
    Normalize.normalize(word)
  end

  @doc """
  Normalizes a verb/adjective
  Turn 해요 into 하 etc

  This uses stem() which can be destructive
  Turning 늘다 into 느다
  """
  def normalize_destructive(word) do
    Normalize.normalize_destructive(word)
  end

  @doc """
  Find a word in a file
  """
  def find_in_file(file, word) do
    File.read!(file)
    |> String.split("\n")
    |> Enum.find(fn x -> x == word end)
  end

  @doc """
  Add an ending to a word
  In case no word is found, we return nil
  """
  def add_ending(word, ending) do
    case word do
      nil -> nil
      word -> word <> ending
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
end
