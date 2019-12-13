defmodule KoreanSentenceAnalyser.Josa do
  @moduledoc """
  Functions related to Korean Josa's
  A Josa is a grammar particle added to the end of words
  """
  
  @doc """
  Remove a Josa ending
  """
  def remove(word) do
    result = File.read!("data/josa/josa.txt")
             |> String.split("\n")
             |> Enum.sort(&(String.length(&1) >= String.length(&2)))
             |> Enum.find(fn x -> Regex.match?(Regex.compile!(x <> "$", "u"), word) end)
    
    case result do
      nil -> word
      match ->
        Regex.replace(Regex.compile!(match <> "$", "u"), word, "")
    end
  end
end
