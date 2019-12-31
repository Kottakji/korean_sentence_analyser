defmodule KSA.Adverb do
  @moduledoc false

  @data_type "Adverb"
  @file_path "adverb/adverb.txt"

  @doc """
  Find if the word is an adverb

      iex> KSA.Adverb.find("가강히")
      %{"specific_type" => "Adverb", "token" => "가강히", "type" => "Adverb"}
  """
  def find(word) do
    word
    |> KSA.LocalDict.find_in_file(@file_path)
    |> KSA.Formatter.print_result(@data_type)
  end
end
