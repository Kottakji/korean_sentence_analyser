defmodule Conjunction do
  @moduledoc false

  alias LocalDict
  alias Formatter
  @data_type "Conjunction"
  @file_path "data/auxiliary/conjunctions.txt"

  @doc """
  Find if the word is a conjunction
  """
  def conjunction(word) do
    word
    |> LocalDict.find_in_file(@file_path)
    |> Formatter.print_result(@data_type)
  end
end
