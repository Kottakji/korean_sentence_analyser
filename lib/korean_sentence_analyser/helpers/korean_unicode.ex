defmodule KoreanSentenceAnalyser.Helpers.KoreanUnicode do
  @moduledoc """
  Contains functions helpful in dealing with Hangul

  Explanation can be found at:
  https://en.wikipedia.org/wiki/Korean_language_and_computers#Hangul_in_Unicode
  """
  @jamo_start_location_in_unicode 4352
  @start_location_in_unicode 44032
  @characters_per_initial 588
  @characters_per_medial 28

  @doc """
  Split a sentence into only Korean words
  """
  def split("") do
    ""
  end

  def split(<<decimal_point::utf8, rest::binary>>) do
    split(rest, create_from_decimal_point(decimal_point), "")
  end

  defp split(<<decimal_point::utf8, rest::binary>>, nil, acc) do
    acc =
      case String.last(acc) do
        nil -> acc
        " " -> acc
        _character -> acc <> " "
      end

    split(rest, create_from_decimal_point(decimal_point), acc)
  end

  defp split(<<decimal_point::utf8, rest::binary>>, character, acc)
       when decimal_point > @jamo_start_location_in_unicode and decimal_point < @start_location_in_unicode do
    split(rest, character, acc)
  end

  defp split(<<decimal_point::utf8, rest::binary>>, character, acc) do
    split(rest, create_from_decimal_point(decimal_point), acc <> character)
  end

  defp split("", nil, acc) do
    String.split(acc)
  end

  defp split("", character, acc) do
    String.split(acc <> character)
  end

  @doc """
  Create a Hangul character from a decimal point
  If it's not a valid Hangul character, we return a whitespace
  https://en.wikipedia.org/wiki/Hangul_Syllables
  """
  def create_from_decimal_point(decimal_point)
      when decimal_point <= 55209 and decimal_point >= 44032 do
    <<decimal_point::utf8>>
  end

  def create_from_decimal_point(_decimal_point) do
    nil
  end

  @doc """
  Does it start with a certain hangul?
  https://en.wikipedia.org/wiki/Hangul
  """
  def starts_with?("", _match) do
    false
  end

  def starts_with?(nil, _match) do
    false
  end

  def starts_with?(word, match) do
    deduct_jamo_start(get_unicode_decimal_value(match)) == Float.floor(deduct_start(get_unicode_decimal_value(String.first(word))) / @characters_per_initial)
  end

  @doc """
  Get the decimal value of a character
  """
  def get_unicode_decimal_value(<<decimal_value::utf8>>) do
    decimal_value
  end

  @doc """
  Deduct the Jamo (ㅁ,ㅋ,ㄱ,ㅏ etc) start location in unicode from the decimal value
  """
  def deduct_jamo_start(decimal_value) do
    decimal_value - @jamo_start_location_in_unicode
  end

  @doc """
  Deduct the start location in unicode from the decimal value
  """
  def deduct_start(decimal_value) do
    decimal_value - @start_location_in_unicode
  end

  @doc """
  Get the initial consonant decimal value from a decimal value
  Make sure to use deduct_start()/1 first
  """
  def get_initial_consonant(decimal_value) do
    (decimal_value / @characters_per_initial)
    |> floor
  end

  @doc """
  Get the medial vowel decimal value from the a decimal value
  Make sure to use deduct_start()/1 first
  """
  def get_medial_vowel(decimal_value) do
    decimal_value = decimal_value - get_initial_consonant(decimal_value) * @characters_per_initial

    (decimal_value / @characters_per_medial)
    |> floor
  end

  @doc """
  Get the final consonant decimal value from the a decimal value
  Make sure to use deduct_start()/1 first
  """
  def get_final_consonant(decimal_value) do
    decimal_value = decimal_value - get_initial_consonant(decimal_value) * @characters_per_initial

    (decimal_value - get_medial_vowel(decimal_value) * @characters_per_medial)
    |> floor
  end

  @doc """
  Create a character from decimal values
  The start location is automatically added
  """
  def create_character(
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
