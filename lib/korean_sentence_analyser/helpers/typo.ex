defmodule KoreanSentenceAnalyser.Helpers.Typo do
  @moduledoc """
  Can fix certain typo's
  """

  alias KoreanSentenceAnalyser.Helpers.Dict
  @file_path "data/typos/typos.txt"

  @doc """
  Find a typo and return the new word if found
  """
  def find(word) do
    case Dict.find_in_file(word, @file_path) do
      nil -> word
      match -> match
    end
  end
end
