defmodule KoreanSentenceAnalyser.DataTypes.Josa do
  @moduledoc """
  A Josa is grammar particle that can be added to words
  """
  alias KoreanSentenceAnalyser.Helpers.Dict
  @file_path "data/josa/josa.txt"

  @doc """
  Remove a Josa ending
  """
  def remove(word) do
    case Dict.find_ending_in_file(word, @file_path) do
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
