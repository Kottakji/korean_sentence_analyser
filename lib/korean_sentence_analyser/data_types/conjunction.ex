defmodule KSA.Conjunction do
  @moduledoc false

  @data_type "Conjunction"
  @file_path "auxiliary/conjunctions.txt"

  @doc """
  Find if the word is a conjunction

      iex> KSA.Conjunction.find("그럼")
      %{"specific_type" => "Conjunction","token" => "그럼","type" => "Conjunction"}
    
  """
  def find(word) do
    word
    |> KSA.LocalDict.find_in_file(@file_path)
    |> KSA.Formatter.print_result(@data_type)
  end
end
