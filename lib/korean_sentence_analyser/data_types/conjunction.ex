defmodule KoreanSentenceAnalyser.DataTypes.Conjunction do
  @moduledoc false

  alias KoreanSentenceAnalyser.Helpers.Dict
  alias KoreanSentenceAnalyser.Helpers.Formatter
  @data_type "Conjunction"
  @file_path "data/auxiliary/conjunctions.txt"

  @doc """
  Find if the word is a conjunction
  """
  def conjunction(word) do
    word
    |> Dict.find_in_file(@file_path)
    |> Formatter.print_result(@data_type)
  end
end
