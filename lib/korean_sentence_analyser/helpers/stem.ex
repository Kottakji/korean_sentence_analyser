defmodule KoreanSentenceAnalyser.Helpers.Stem do
  alias KoreanSentenceAnalyser.Helpers.KoreanUnicode

  @moduledoc """
  Module that helps with finding the stem of words
  """

  @doc """
  Finds the stem of a word
  Warning: This method can be destructive
  늘다 can be turned into 느다
  So, always check if the verb/adjective is already valid, before trying to find a stem
  """
  def find(word) do
    conjugate(word, String.last(word))
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
    decimal_value =
      KoreanUnicode.get_unicode_decimal_value(last_char)
      |> KoreanUnicode.deduct_start()

    case conjugate?(KoreanUnicode.get_final_consonant(decimal_value)) do
      true ->
        # Create the base character
        character =
          KoreanUnicode.create_character(
            KoreanUnicode.get_initial_consonant(decimal_value),
            KoreanUnicode.get_medial_vowel(decimal_value),
            0
          )

        # Replace the last character
        word = String.replace_suffix(word, last_char, character)

        # Conjugate again for 했 etc
        case conjugate(word, character) do
          nil -> word
          match -> match
        end

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
end
