defmodule KoreanSentenceAnalyser.DataTypes.Josa do
  alias KoreanSentenceAnalyser.Helpers.Dict

  @moduledoc """
  Functions related to Korean Josa's
  A Josa is a grammar particle added to the end of words
  """

  @doc """
  Remove a Josa ending
  """
  def remove(word) do
    case Dict.find_ending_in_file(word, "data/josa/josa.txt") do
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
