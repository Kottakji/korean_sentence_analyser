defmodule KoreanSentenceAnalyser.Helpers.KoreanUnicode do
  @moduledoc """
  Contains functions helpful in dealing with Hangul
  """
  
  
  @doc """
  Split a sentence into only Korean words
  """
  def split("") do
    ""
  end
  
  def split(<<decimal_point :: utf8, rest :: binary>>) do
    split(rest, create_from_decimal_point(decimal_point), "")
  end

  defp split(<<decimal_point :: utf8, rest :: binary>>, nil, acc) do
    acc = case String.last(acc) do
      nil -> acc
      " " -> acc
      _character -> acc <> " "
    end
    
    split(rest, create_from_decimal_point(decimal_point), acc)
  end
  
  defp split(<<decimal_point :: utf8, rest :: binary>>, character, acc) do
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
  def create_from_decimal_point(decimal_point) when decimal_point <= 55209 and decimal_point >= 44032 do
    <<decimal_point :: utf8>>
  end
  
  def create_from_decimal_point(_decimal_point) do
    nil
  end
end
