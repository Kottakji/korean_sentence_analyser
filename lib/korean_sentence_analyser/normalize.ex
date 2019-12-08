defmodule KoreanSentenceAnalyser.Normalize do
  @moduledoc """
  We can try to normalize words by removing their eomi/pre-eomi
  """
  
  @doc """
  Removes the eomi endings
  Can be called multiple times to remove pre-eomi endings as well
  """
  def normalize(word) do
    # Remove the eomi ending
    result = remove_eomi_ending(word)
    
    # In case it's already removed, we try to remove the pre_eomi
    # This can happen recursive, but we do this in the verb/adjective class
    # Because we need to check if we already have a matching verb/adjective
    case result == word do
      true ->
        remove_pre_eomi_ending(word)
      false ->
        result
    end
  end
  
  defp remove_eomi_ending(word) do
    case find_eomi_ending(word) do
      nil ->
        # Not found, just return the word
        word
      match ->
        # Replace the match, so we can create the stem
        Regex.replace(Regex.compile!(match <> "$", "u"), word, "")
    end
  end
  
  defp find_eomi_ending(word) do
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
        # Search the Eomi list
        File.read!("data/verb/eomi.txt")
        |> String.split("\n")
        |> Enum.sort(&(String.length(&1) >= String.length(&2)))
        |> Enum.find(fn x -> Regex.match?(Regex.compile!(x <> "$", "u"), word) end)
    end
  end
  
  defp remove_pre_eomi_ending(word) do
    case find_pre_eomi_ending(word) do
      nil -> word
      match ->
        Regex.replace(Regex.compile!(match <> "$", "u"), word, "")
    end
  end
  
  defp find_pre_eomi_ending(word) do
    File.read!("data/verb/pre_eomi.txt")
    |> String.split("\n")
    |> Enum.sort(&(String.length(&1) >= String.length(&2)))
    |> Enum.find(fn x -> Regex.match?(Regex.compile!(x <> "$", "u"), word) end)
  end
end
