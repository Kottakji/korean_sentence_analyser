defmodule Josa do
  @moduledoc """
  A Josa is grammar particle that can be added to words
  """

  alias LocalDict
  @file_path "data/josa/josa.txt"

  @doc """
  Remove a Josa ending
  
      iex> Josa.remove("당신의")
      "당신"
  """
  def remove(word) do
    case LocalDict.find_ending_in_file(word, @file_path) do
      nil ->
        word

      match ->
        case Regex.replace(Regex.compile!(match <> "$", "u"), word, "") do
          # Make sure we don't return an empty string, when we give only a josa as input, else the words will always match
          "" -> word
          result -> result
        end
    end
  end
end
