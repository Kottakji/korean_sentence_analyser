defmodule KoreanSentenceAnalyser.DataTypes.Eomi do
  @moduledoc """
  An Eomi is a conjugation added to Korean words
  """
  
  alias KoreanSentenceAnalyser.DataTypes.PreEomi
  alias KoreanSentenceAnalyser.Helpers.Dict
  alias KoreanSentenceAnalyser.Helpers.Stem
  alias KoreanSentenceAnalyser.Helpers.Formatter

  @doc """
  Remove the Eomi from the word
  Can (should) be called recursively
  If the result is not the same word or nil, you can lookup the word, or call this method again to remove more
  """
  def remove(word) do
    # Remove the eomi ending
    result = remove_ending(word)

    # In case it's already removed, we try to remove the pre_eomi
    # This can happen recursive, but we do this in the verb/adjective class
    # Because we need to check if we already have a matching verb/adjective
    case result == word do
      true ->
        PreEomi.remove(word)

      false ->
        result
    end
  end

  defp remove_ending(word) do
    case find_ending(word) do
      nil ->
        # Not found, just return the word
        word

      match ->
        # Replace the match, so we can create the stem
        case Regex.replace(Regex.compile!(match <> "$", "u"), word, "") do
          "" -> nil
          match -> match
        end
    end
  end

  defp find_ending(word) do
    cond do
      # Those that do not appear in the eomi list
      # Note, we do not remove the complete ending, that will happen later on
      # Else we don't know the stem
      Regex.match?(~r/하다$/u, word) ->
        "다"

      Regex.match?(~r/해$/u, word) ->
        ""

      Regex.match?(~r/되다$/u, word) ->
        "다"

      Regex.match?(~r/돼$/u, word) ->
        ""

      true ->
        Dict.find_ending_in_file(word, "data/verb/eomi.txt")
    end
  end
end
