defmodule KoreanSentenceAnalyser.Normalize do
  import KoreanSentenceAnalyser.Stem

  @doc """
  Removes the eomi endings
  """
  def normalize(word) do
    remove_eomi_ending(word)
  end

  @doc """
  Removes the eomi endings

  This method can be destructive
  늘다 can be turned into 느다
  So, always check if the verb/adjective is already valid, before stemming
  """
  def normalize_destructive(word) do
    remove_eomi_ending(word, true)
  end

  defp remove_eomi_ending(word, destructive \\ false) do
    case find_eomi_ending(word) do
      nil ->
        # Not found, just return the word
        word

      match ->
        # Replace the match, so we can create the stem
        word = Regex.replace(Regex.compile!(match <> "$", "u"), word, "")

        # We might be left with something like 가능한, which needs to become 가능하
        # Return the word with the stem from one of: 하다, 되다 없다, 있다
        case destructive do
          true -> stem(word)
          false -> word
        end
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
end
