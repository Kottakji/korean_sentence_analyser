defmodule Typo do
  @moduledoc """
  Can fix certain typo's
  """

  @file_path "typos/typos.txt"

  @doc """
  Find a typo and return the new word if found

      iex> Typo.find("십알")
      "씨발"
    
  """
  def find(word) do
    case LocalDict.find_in_file(word, @file_path) do
      nil -> word
      match -> match
    end
  end
end
