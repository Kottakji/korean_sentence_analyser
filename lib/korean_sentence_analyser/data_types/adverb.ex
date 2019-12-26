defmodule KoreanSentenceAnalyser.DataTypes.Adverb do
  alias KoreanSentenceAnalyser.Helpers.Dict
  alias KoreanSentenceAnalyser.Helpers.Formatter
  @data_type "Adverb"
  @file_path "data/adverb/adverb.txt"

  @doc """
  Find if the word is an adverb
  """
  def find(word) do
    word
    |> Dict.find_in_file(@file_path)
    |> Formatter.print_result(@data_type)
  end
end
