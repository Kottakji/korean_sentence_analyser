defmodule KoreanSentenceAnalyser.Normalize do
  def normalize(word) do
    remove_eomi_ending(word)
  end
  
  defp remove_eomi_ending(word) do
    case find_eomi_ending(word) do
      nil ->
        # Not found, just return the word
        word
      
      match ->
        # Replace the match, so we can create the stem
        word = Regex.replace(Regex.compile!(match <> "$", "u"), word, "")
        
        # We might be left with something like 가능한, which needs to become 가능하
        # Return the word with the stem from one of: 하다, 되다 없다, 있다
        last_char = String.last(word)
        
        cond do
          # Replace the last character based which ending we want for this word
          # 돼 becomes 되, but also mismatches like 잇 become 있
          # https://en.wikipedia.org/wiki/Hangul_Syllables
          Regex.match?(~r/[\x{D558}-\x{D5C7}]/u, word) ->
            String.replace_suffix(word, last_char, "하")
          
          Regex.match?(~r/[\x{B3C4}-\x{B434}]/u, word) ->
            String.replace_suffix(word, last_char, "되")
          
          Regex.match?(~r/[\x{C787}-\x{C788}]/u, word) ->
            String.replace_suffix(word, last_char, "있")
          
          Regex.match?(~r/[\x{C5C5}-\x{C5C7}]/u, word) ->
            String.replace_suffix(word, last_char, "없")
          
          # Fallback
          true ->
            word
        end
    end
  end
  
  defp find_eomi_ending(word) do
    cond do
      # Those that do not appear in the eomi list
      # Note, we do not remove the complete ending, that will happen later on
      # Else we don't know the stem
      Regex.match?(~r/하다$/u, word) -> "다"
      Regex.match?(~r/해$/u, word) -> ""
      Regex.match?(~r/되다$/u, word) -> "다"
      Regex.match?(~r/돼$/u, word) -> ""
      true ->
        # Search the Eomi list
        File.read!("data/verb/eomi.txt")
        |> String.split("\n")
        |> Enum.sort(&(String.length(&1) >= String.length(&2)))
        |> Enum.find(fn x -> Regex.match?(Regex.compile!(x <> "$", "u"), word) end)
    end
  end
  
  defp is_exception(match) do
    case match do
      # This would change 가능해 to 가능 instead of 가능하
      "해" -> true
      _ -> false
    end
  end
end
