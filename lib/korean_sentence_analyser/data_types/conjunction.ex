defmodule Conjunction do
  @moduledoc false

  alias LocalDict
  alias Formatter
  @data_type "Conjunction"
  @file_path "data/auxiliary/conjunctions.txt"

  @doc """
  Find if the word is a conjunction
  
      iex> Conjunction.find("그럼")
      %{"specific_type" => "Conjunction","token" => "그럼","type" => "Conjunction"}
    
  """
  def find(word) do
    word
    |> LocalDict.find_in_file(@file_path)
    |> Formatter.print_result(@data_type)
  end
end
