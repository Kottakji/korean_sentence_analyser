defmodule Ksa.Support.Unicode do
  @moduledoc """
  Contains functions helpful in dealing with Hangul
  
  Explanations can be found at: \n
  https://en.wikipedia.org/wiki/Korean_language_and_computers#Hangul_in_Unicode \n
  https://en.wikipedia.org/wiki/Hangul_Jamo_(Unicode_block)
  
  """
  
  @jamo_initial_start_location_in_unicode 4352
  @jamo_medial_start_location_in_unicode 4449
  @jamo_final_start_location_in_unicode 4519
  @start_location_in_unicode 44_032
  @characters_per_initial 588
  @characters_per_medial 28
  
  @doc """
  Split a sentence into only Korean words
  
      iex> Ksa.Support.Unicode.split("투표......당신의 소중한  한표....ㅋㅋ")
      ["투표", "당신의", "소중한", "한표"]
    
  """
  def split("") do
    ""
  end
  
  def split(<<decimal_point::utf8, rest::binary>>) do
    split(rest, create_hangul_from_decimal_value(decimal_point), "")
  end
  
  defp split(<<decimal_point::utf8, rest::binary>>, nil, acc) do
    acc =
      case String.last(acc) do
        nil -> acc
        " " -> acc
        _character -> acc <> " "
      end
    
    split(rest, create_hangul_from_decimal_value(decimal_point), acc)
  end
  
  defp split(<<decimal_point::utf8, rest::binary>>, character, acc)
       when decimal_point > @jamo_initial_start_location_in_unicode and decimal_point < @start_location_in_unicode do
    split(rest, character, acc)
  end
  
  defp split(<<decimal_point::utf8, rest::binary>>, "를", acc) do
    split(rest, create_hangul_from_decimal_value(decimal_point), acc <> " ")
  end
  
  defp split(<<decimal_point::utf8, rest::binary>>, character, acc) do
    split(rest, create_hangul_from_decimal_value(decimal_point), acc <> character)
  end
  
  defp split("", nil, acc) do
    String.split(acc)
  end
  
  defp split("", character, acc) do
    String.split(acc <> character)
  end
  
  @doc """
  Create a unicode character from a decimal value
    
      iex> Ksa.Support.Unicode.create_from_decimal_value(55200)
      "힠"
  
  """
  def create_from_decimal_value(decimal_value) do
    <<decimal_value::utf8>>
  end
  
  @doc """
  Create a unicode hangul character from a decimal value\n
  Note: Does not create Jamo, only Hangul
  
      iex> Ksa.Support.Unicode.create_hangul_from_decimal_value(44032)
      "가"
    
  """
  def create_hangul_from_decimal_value(decimal_value) when decimal_value <= 55_209 and decimal_value >= 44_032 do
    <<decimal_value::utf8>>
  end
  
  def create_hangul_from_decimal_value(_) do
    nil
  end
  
  @doc """
  Does it start with a certain Jamo?
  
      iex> Ksa.Support.Unicode.starts_with?("가", "ᄀ")
      true
  """
  def starts_with?("", _jamo) do
    false
  end
  
  def starts_with?(nil, _jamo) do
    false
  end
  
  def starts_with?(character, jamo) do
    get_initial_consonant(character) == jamo
  end
  
  @doc """
  Does the medial vowel match a certain Jamo?
  
      iex> Ksa.Support.Unicode.has_medial_vowel?("쳐", "ᅧ")
      true
  """
  def has_medial_vowel?("", _jamo) do
    false
  end
  
  def has_medial_vowel?(nil, _jamo) do
    false
  end
  
  def has_medial_vowel?(character, jamo) do
    get_medial_vowel(character) == jamo
  end
  
  @doc """
  Does it end with a certain Jamo?
  
      iex> Ksa.Support.Unicode.ends_with_final?("씻", "ᆺ")
      true
    
  """
  def ends_with_final?("", _jamo) do
    false
  end
  
  def ends_with_final?(nil, _jamo) do
    false
  end
  
  def ends_with_final?(character, jamo) do
    get_final_consonant(character) == jamo
  end
  
  @doc """
  Get the decimal value of a character
  
      iex> Ksa.Support.Unicode.get_unicode_decimal_value("는")
      45716
    
  """
  def get_unicode_decimal_value(<<decimal_value::utf8>>) do
    decimal_value
  end
  
  @doc """
  Deduct the start location in unicode from the decimal value
  """
  def deduct_unicode_start_location(decimal_value) do
    decimal_value - @start_location_in_unicode
  end
  
  @doc """
  Create a unicode character from code points
  
      iex> Ksa.Support.Unicode.create_from_code_points(0,0,0)
      "가"
      
      iex> Ksa.Support.Unicode.create_from_code_points(1,0,3)
      "깏"
    
  """
  def create_from_code_points(initial_consonant_code_point, medial_vowel_code_point, final_consonant_code_point) do
    decimal =
      @start_location_in_unicode +
        initial_consonant_code_point * @characters_per_initial +
        medial_vowel_code_point * @characters_per_medial +
        final_consonant_code_point
    
    <<decimal::utf8>>
  end
  
  @doc """
  Change the medial voewel of a character
  If you pass in a word, it will change the final consonant of the last character
  
      iex> Ksa.Support.Unicode.change_medial_vowel("지쳐", "ᅵ")
      "지치"
    
  """
  def change_medial_vowel(word, new_medial_vowel) when byte_size(word) > 3 do
    last = String.last(word)
    remains = Ksa.Support.String.get_remaining(word, last)
    remains <> change_medial_vowel(last, new_medial_vowel)
  end
  
  def change_medial_vowel(character, new_medial_vowel) do
    create_from_code_points(
      get_initial_code_point(character),
      get_unicode_decimal_value(new_medial_vowel) - @jamo_medial_start_location_in_unicode,
      get_final_code_point(character)
    )
  end
  
  @doc """
  Change the final consonant of a character
  If you pass in a word, it will change the final consonant of the last character
  
      iex> Ksa.Support.Unicode.change_final_consonant("노랗", "ᆫ")
      "노란"
    
  """
  def change_final_consonant(word, new_final_consonant) when byte_size(word) > 3 do
    last = String.last(word)
    remains = Ksa.Support.String.get_remaining(word, last)
    remains <> change_final_consonant(last, new_final_consonant)
  end
  
  def change_final_consonant(character, new_final_consonant) do
    create_from_code_points(
      get_initial_code_point(character),
      get_medial_code_point(character),
      get_unicode_decimal_value(new_final_consonant) - @jamo_final_start_location_in_unicode
    )
  end
  
  @doc """
  Remove a final consonant and return the string without it
  
      iex> Ksa.Support.Unicode.remove_final_consonant("마실")
      "마시"
    
  """
  def remove_final_consonant(word) when byte_size(word) > 3 do
    last = String.last(word)
    remains = Ksa.Support.String.get_remaining(word, last)
    remains <> remove_final_consonant(last)
  end
  
  def remove_final_consonant(character) do
    create_from_code_points(
      get_initial_code_point(character),
      get_medial_code_point(character),
      0
    )
  end
  
  @doc """
  Get the initial consonant code point
  
      iex> Ksa.Support.Unicode.get_initial_code_point("한")
      18
    
  """
  def get_initial_code_point(character) when byte_size(character) == 3 do
    character
    |> get_unicode_decimal_value
    |> deduct_unicode_start_location
    |> div(@characters_per_initial)
    |> floor()
  end
  
  def get_initial_code_point(_) do
    nil
  end
  
  @doc """
  Get the initial consonant decimal value
  
      iex> Ksa.Support.Unicode.get_initial_consonant("한")
      "ᄒ"
    
  """
  def get_initial_consonant(character) when byte_size(character) == 3 do
    (get_initial_code_point(character) + @jamo_initial_start_location_in_unicode)
    |> create_from_decimal_value
  end
  
  def get_initial_consonant(_) do
    nil
  end
  
  @doc """
  Get the medial vowel code point
  
      iex> Ksa.Support.Unicode.get_medial_code_point("한")
      0
    
  """
  def get_medial_code_point(character) when byte_size(character) == 3 do
    character
    |> get_unicode_decimal_value
    |> deduct_unicode_start_location
    |> rem(@characters_per_initial)
    |> div(@characters_per_medial)
    |> floor()
  end
  
  def get_medial_code_point(_) do
    nil
  end
  
  @doc """
  Get the medial vowel
  
      iex> Ksa.Support.Unicode.get_medial_vowel("해")
      "ᅢ"
    
  """
  def get_medial_vowel(character) when byte_size(character) == 3 do
    (get_medial_code_point(character) + @jamo_medial_start_location_in_unicode)
    |> create_from_decimal_value
  end
  
  def get_medial_vowel(_) do
    nil
  end
  
  @doc """
  Get the final consonant code point
  
      iex> Ksa.Support.Unicode.get_final_code_point("한")
      4
  
      iex> Ksa.Support.Unicode.get_final_code_point("해")
      0
    
  """
  def get_final_code_point(character) when byte_size(character) == 3 do
    character
    |> get_unicode_decimal_value
    |> deduct_unicode_start_location
    |> rem(@characters_per_initial)
    |> rem(@characters_per_medial)
    |> floor()
  end
  
  def get_final_code_point(_) do
    nil
  end
  
  @doc """
  Get the final consonant
  
      iex> Ksa.Support.Unicode.get_final_consonant("한")
      "ᆫ"
  
      iex> Ksa.Support.Unicode.get_final_consonant("해")
      nil
    
  """
  def get_final_consonant(character) when byte_size(character) == 3 do
    case get_final_code_point(character) do
      0 ->
        nil
      
      code_point ->
        (code_point + @jamo_final_start_location_in_unicode)
        |> create_from_decimal_value
    end
  end
  
  def get_final_consonant(_) do
    nil
  end
end
