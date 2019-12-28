defmodule Adverb do
  @moduledoc false

  alias LocalDict
  alias Formatter
  @data_type "Adverb"
  @file_path "data/adverb/adverb.txt"

  @doc """
  Find if the word is an adverb
  
    iex> Adverb.find("가강히")
    %{"specific_type" => "Adverb", "token" => "가강히", "type" => "Adverb"}
  """
  def find(word) do
    word
    |> LocalDict.find_in_file(@file_path)
    |> Formatter.print_result(@data_type)
  end
end
