defmodule KoreanSentenceAnalyser.DataTypes.Eomi do
  alias KoreanSentenceAnalyser.DataTypes.PreEomi
  alias KoreanSentenceAnalyser.Helpers.Dict
  alias KoreanSentenceAnalyser.Helpers.Stem
  alias KoreanSentenceAnalyser.Helpers.Formatter
  @moduledoc """
  We can try to normalize words by removing their eomi/pre-eomi
  """
  
  @doc """
  Removes the eomi endings
  Can be called multiple times to remove pre-eomi endings as well
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

  @doc """
  Remove Eomi recursively
  """
  def remove_recursively(word, file, data_type) do
    case Dict.find_in_file(word, file) do
      nil ->
        new_word = remove(word)
        cond do
          new_word == "" ->
            # Stop when the string is emptied
            nil
          new_word == word ->
            # It's the same one, do not keep looking for a word
            # We can try the stem as a final resort
            word
            |> Stem.stem()
            |> Dict.find_in_file(file)
          true ->
            # Keep trying to find a word,
            remove_recursively(new_word, file, data_type)
        end
      word -> word
    end
  end
  
  defp remove_ending(word) do
    case find_ending(word) do
      nil ->
        # Not found, just return the word
        word
      match ->
        # Replace the match, so we can create the stem
        Regex.replace(Regex.compile!(match <> "$", "u"), word, "")
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
