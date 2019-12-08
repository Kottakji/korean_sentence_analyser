defmodule KoreanSentenceAnalyser.Stem do
  @moduledoc """
  Explanation can be found at:
  https://en.wikipedia.org/wiki/Korean_language_and_computers#Hangul_in_Unicode
  """
  @start_location_in_unicode 44032
  @characters_per_initial 588
  @characters_per_medial 28

  @doc """
  This method can be destructive
  늘다 can be turned into 느다
  So, always check if the verb/adjective is already valid, before stemming
  """
  def stem(word) do
    last_char = String.last(word)

    conjugate(word, last_char)
  end

  defp conjugate(word, "해") do
    # Special ending of the word 하다
    String.replace_suffix(word, "해", "하")
  end

  defp conjugate(word, "돼") do
    # Special ending of the word 되다
    String.replace_suffix(word, "돼", "되")
  end

  defp conjugate(word, "았") do
    # Remove these character, it's only a past tense indicator
    String.replace_suffix(word, "았", "")
  end

  defp conjugate(word, "었") do
    # Remove these character, it's only a past tense indicator
    String.replace_suffix(word, "었", "")
  end

  defp conjugate(word, "을") do
    # Remove these character, it's only a future tense indicator
    String.replace_suffix(word, "을", "")
  end

  defp conjugate(word, "있") do
    # Do not remove, it means 'is' and is attached to adjectives/verbs
    word
  end

  defp conjugate(word, "없") do
    # Do not remove, it means 'not is' and is attached to adjectives/verbs
    word
  end

  defp conjugate(word, last_char) do
    decimal_value = get_unicode_decimal_value(last_char)

    case conjugate?(get_final_consonant(decimal_value)) do
      true ->
        # Create the base character
        character =
          create_character(
            get_initial_consonant(decimal_value),
            get_medial_vowel(decimal_value),
            0
          )

        # Replace the last character
        String.replace_suffix(word, last_char, character)

      false ->
        # No need to replace anything
        nil
    end
  end

  defp conjugate?(final_consonant_decimal_value) do
    case final_consonant_decimal_value do
      # ㄴ
      4 ->
        true

      # ㄹ
      8 ->
        true

      # ㅁ
      16 ->
        true

      # ㅆ
      20 ->
        true

      _ ->
        false
    end
  end

  defp get_unicode_decimal_value(codepoint) do
    <<x::utf8>> = codepoint

    # Remove the start location, so we can use an algorithm
    x - @start_location_in_unicode
  end

  defp get_initial_consonant(decimal_value) do
    (decimal_value / @characters_per_initial)
    |> floor
  end

  defp get_medial_vowel(decimal_value) do
    decimal_value = decimal_value - get_initial_consonant(decimal_value) * @characters_per_initial

    (decimal_value / @characters_per_medial)
    |> floor
  end

  defp get_final_consonant(decimal_value) do
    decimal_value = decimal_value - get_initial_consonant(decimal_value) * @characters_per_initial

    (decimal_value - get_medial_vowel(decimal_value) * @characters_per_medial)
    |> floor
  end

  defp create_character(
         initial_consonant_decimal_value,
         medial_vowel_decimal_value,
         final_consonant_decimal_value
       ) do
    decimal =
      @start_location_in_unicode + initial_consonant_decimal_value * @characters_per_initial +
        medial_vowel_decimal_value * @characters_per_medial + final_consonant_decimal_value

    <<decimal::utf8>>
  end
end
