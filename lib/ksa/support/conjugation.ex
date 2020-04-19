defmodule Ksa.Support.Conjugation do
  @moduledoc """
  Helper functions for conjugation
  
  Useful links:
  https://www.koreanwikiproject.com/wiki/%EC%95%84/%EC%96%B4/%EC%97%AC_%2B_%EC%9A%94
  https://www.koreanwikiproject.com/wiki/Category:Irregular_verbs
  https://koreanverb.app/
  """
  alias Ksa.Support.Unicode
  
  @spec conjugate(String.t()) :: String.t()
  def conjugate(word) when byte_size(word) == 3 do
    conjugate({"", word}, {"", word})
  end
  
  @spec conjugate(String.t()) :: String.t()
  def conjugate(word) when byte_size(word) == 6 do
    conjugate(String.split_at(word, -1), {"", String.first(word)})
  end
  
  @spec conjugate(String.t()) :: String.t()
  def conjugate(word) when byte_size(word) > 6 do
    conjugate(String.split_at(word, -1), String.split_at(String.slice(word, 0..-2), -1))
  end
  
  @spec conjugate(tuple(), tuple()) :: String.t()
  def conjugate({last_remaining, last}, {second_last_remaining, second_last}) do
    cond do
      # Past tense (covers 2 characters)
      Unicode.get_final_consonant(second_last) == "ᆻ" and second_last != "있" ->
        second_last = Unicode.remove_final_consonant(second_last)
        
        cond do
          Unicode.get_medial_vowel(second_last) == "ᅢ" ->
            second_last_remaining <> Unicode.change_medial_vowel(second_last, "ᅡ")
          
          Unicode.get_medial_vowel(second_last) == "ᅥ" ->
            second_last_remaining <> Unicode.change_medial_vowel(second_last, "ᅳ")
          
          Unicode.get_medial_vowel(second_last) == "ᅯ" ->
            second_last_remaining <> Unicode.change_medial_vowel(second_last, "ᅮ")
          
          true ->
            second_last_remaining <> second_last
        end
      
      # Present tense
      last == "어" ->
        last_remaining
      
      Unicode.get_final_consonant(last) == nil and Unicode.get_medial_vowel(last) == "ᅢ" ->
        last_remaining <> Unicode.change_medial_vowel(last, "ᅡ")
      
      Unicode.get_final_consonant(last) == nil and Unicode.get_medial_vowel(last) == "ᅥ" ->
        last_remaining <> Unicode.change_medial_vowel(last, "ᅳ")
      
      Unicode.get_final_consonant(last) == nil and Unicode.get_medial_vowel(last) == "ᅯ" ->
        last_remaining <> Unicode.change_medial_vowel(last, "ᅮ")
      
      true ->
        last_remaining <> last
    end
  end
  
  @spec conjugate_irregular(String.t()) :: list
  def conjugate_irregular(word) when byte_size(word) == 3 do
    conjugate_irregular({"", word}, {"", word})
  end
  
  @spec conjugate_irregular(String.t()) :: list
  def conjugate_irregular(word) when byte_size(word) == 6 do
    conjugate_irregular(String.split_at(word, -1), {"", String.first(word)})
  end
  
  @spec conjugate_irregular(String.t()) :: list
  def conjugate_irregular(word) when byte_size(word) > 6 do
    conjugate_irregular(String.split_at(word, -1), String.split_at(String.slice(word, 0..-2), -1))
  end
  
  @spec conjugate_irregular(tuple(), tuple()) :: list
  def conjugate_irregular(last, second_last) do
    
    [
      [conjugate_irregular_dieut(last, second_last)],
      [conjugate_irregular_rieul(last, second_last)],
      [conjugate_irregular_rieul_eu(last, second_last)],
      [conjugate_irregular_sieut(last, second_last)],
      [conjugate_irregular_hieuh_o(last, second_last)],
      [conjugate_irregular_hieuh_a(last, second_last)],
      [conjugate_irregular_bieup(last, second_last)],
    ]
    |> List.flatten()
    |> Enum.filter(fn x -> x != nil end)
  end
  
  @spec conjugate_irregular_dieut(tuple(), tuple()) :: String.t() | nil
  defp conjugate_irregular_dieut({last_remaining, last}, {second_last_remaining, second_last}) do
    cond do
      Unicode.get_final_consonant(second_last) == "ᆻ" and second_last != "있" ->
        cond do
          Unicode.get_final_consonant(second_last) == "ᆯ" ->
            second_last_remaining <> Unicode.change_final_consonant(second_last, "ᆮ")
          
          true ->
            second_last_remaining <> second_last
        end
      
      Unicode.get_final_consonant(last) == "ᆯ" ->
        last_remaining <> Unicode.change_final_consonant(last, "ᆮ")
      
      true -> nil
    end
  end
  
  @spec conjugate_irregular_rieul(tuple(), tuple()) :: String.t()
  defp conjugate_irregular_rieul({_last_remaining, last}, {second_last_remaining, second_last}) do
    cond do
      Unicode.get_final_consonant(second_last) == nil and last == "니" ->
        second_last_remaining <> Unicode.change_final_consonant(second_last, "ᆯ")
      
      true -> nil
    end
  end
  
  @spec conjugate_irregular_rieul_eu(tuple(), tuple()) :: String.t()
  defp conjugate_irregular_rieul_eu({last_remaining, last}, {second_last_remaining, second_last}) do
    cond do
      last == "라" and Unicode.get_final_consonant(second_last) == "ᆯ" ->
        second_last_remaining <> Unicode.remove_final_consonant(second_last) <> "르"
      
      Unicode.get_final_consonant(last) == "ᆸ" ->
        last_remaining <> Unicode.remove_final_consonant(last)
      
      true -> nil
    end
  end
  
  @spec conjugate_irregular_sieut(tuple(), tuple()) :: String.t()
  defp conjugate_irregular_sieut({last_remaining, last}, {_second_last_remaining, _second_last}) do
    cond do
      Unicode.get_final_consonant(last) == nil ->
        last_remaining <> Unicode.change_final_consonant(last, "ᆺ")
      
      true -> nil
    end
  end
  
  @spec conjugate_irregular_hieuh_o(tuple(), tuple()) :: String.t()
  defp conjugate_irregular_hieuh_o({last_remaining, last}, {_second_last_remaining, _second_last}) do
    cond do
      # Past tense
      Unicode.get_final_consonant(last) == "ᆻ" and Unicode.get_medial_vowel(last) == "ᅢ" ->
        last = Unicode.change_medial_vowel(last, "ᅥ")
        last_remaining <> Unicode.change_final_consonant(last, "ᇂ")
      
      # Present tense
      Unicode.get_final_consonant(last) == nil and Unicode.get_medial_vowel(last) == "ᅢ" ->
        last = Unicode.change_medial_vowel(last, "ᅥ")
        last_remaining <> Unicode.change_final_consonant(last, "ᇂ")
      
      # Future tense
      Unicode.get_final_consonant(last) == "ᆯ" ->
        last_remaining <> Unicode.change_final_consonant(last, "ᇂ")
      
      # Imperative
      Unicode.get_final_consonant(last) == nil ->
        last_remaining <> Unicode.change_final_consonant(last, "ᇂ")
      
      true -> nil
    end
  end
  
  @spec conjugate_irregular_hieuh_a(tuple(), tuple()) :: String.t()
  defp conjugate_irregular_hieuh_a({last_remaining, last}, {_second_last_remaining, _second_last}) do
    cond do
      # Past tense
      Unicode.get_final_consonant(last) == "ᆻ" and Unicode.get_medial_vowel(last) == "ᅢ" ->
        last = Unicode.change_medial_vowel(last, "ᅡ")
        last_remaining <> Unicode.change_final_consonant(last, "ᇂ")
      
      # Present tense
      Unicode.get_final_consonant(last) == nil and Unicode.get_medial_vowel(last) == "ᅢ" ->
        last = Unicode.change_medial_vowel(last, "ᅡ")
        last_remaining <> Unicode.change_final_consonant(last, "ᇂ")
      
      # Future tense
      Unicode.get_final_consonant(last) == "ᆯ" ->
        last_remaining <> Unicode.change_final_consonant(last, "ᇂ")
      
      # Imperative
      Unicode.get_final_consonant(last) == nil ->
        last_remaining <> Unicode.change_final_consonant(last, "ᇂ")
      
      true -> nil
    end
  end
  
  @spec conjugate_irregular_bieup(tuple(), tuple()) :: String.t()
  defp conjugate_irregular_bieup({_last_remaining, last}, {second_last_remaining, second_last}) do
    cond do
      # Past tense
      Unicode.get_initial_consonant(second_last) == "ᄇ" and Unicode.get_final_consonant(second_last) == nil ->
        cond do
          # Past
          last == "웠" ->
            second_last_remaining <> Unicode.change_final_consonant(second_last, "ᆸ")
          
          # Present
          last == "워" ->
            second_last_remaining <> Unicode.change_final_consonant(second_last, "ᆸ")
          
          # Future
          last == "울" ->
            second_last_remaining <> Unicode.change_final_consonant(second_last, "ᆸ")
          
          # Imperative
          last == "우" ->
            second_last_remaining <> Unicode.change_final_consonant(second_last, "ᆸ")
          
          true -> nil
        end
      
      true -> nil
    end
  end
end
