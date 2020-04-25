defmodule Ksa.Support.Conjugation do
  @moduledoc """
  Helper functions for conjugation

  Useful links:
  https://www.koreanwikiproject.com/wiki/%EC%95%84/%EC%96%B4/%EC%97%AC_%2B_%EC%9A%94
  https://www.koreanwikiproject.com/wiki/Category:Irregular_verbs
  https://koreanverb.app/
  https://zkorean.com/hangul/appearance
  """
  alias Ksa.Support.Unicode
  alias Ksa.Structs.Conjugated
  use Ksa.Constants

  @spec conjugate(String.t()) :: list
  def conjugate(word) when byte_size(word) == 0 do
    []
  end

  @spec conjugate(String.t()) :: list
  def conjugate(word) when byte_size(word) == 3 do
    conjugate({"", word}, {"", word})
  end

  @spec conjugate(String.t()) :: list
  def conjugate(word) when byte_size(word) == 6 do
    conjugate(String.split_at(word, -1), {"", String.first(word)})
  end

  @spec conjugate(String.t()) :: list
  def conjugate(word) when byte_size(word) > 6 do
    conjugate(String.split_at(word, -1), String.split_at(String.slice(word, 0..-2), -1))
  end

  @spec conjugate(String.t()) :: list
  def conjugate(_word) do
    []
  end

  @spec conjugate(tuple(), tuple()) :: list
  def conjugate(last, second_last) do
    [
      [conjugate_a(last, second_last)],
      [conjugate_eu(last, second_last)],
      [conjugate_rieul(last, second_last)],
      [conjugate_u(last, second_last)],
      [conjugate_past(last, second_last)]
    ]
    |> List.flatten()
    |> Enum.filter(fn x -> x != nil end)
    |> Enum.uniq()
  end

  @spec conjugate_a(tuple(), tuple()) :: list
  defp conjugate_a({last_remaining, last}, {second_last_remaining, second_last}) do
    cond do
      Unicode.get_final_consonant(second_last) == "ᆻ" and second_last != "있" ->
        second_last = Unicode.remove_final_consonant(second_last)

        cond do
          Unicode.get_medial_vowel(second_last) == "ᅢ" ->
            %Conjugated{
              word: last_remaining <> last,
              conjugated: second_last_remaining <> Unicode.change_medial_vowel(second_last, "ᅡ"),
              tense: @past_tense,
              sub_type: @regular
            }

          true ->
            nil
        end

      Unicode.get_final_consonant(last) == nil and Unicode.get_medial_vowel(last) == "ᅢ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.change_medial_vowel(last, "ᅡ"),
          tense: @present_tense,
          sub_type: @regular
        }

      Unicode.get_final_consonant(last) == "ᆸ" and Unicode.get_medial_vowel(last) == "ᅡ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.remove_final_consonant(last),
          tense: @present_formal_tense,
          sub_type: @regular
        }

      Unicode.get_final_consonant(last) == "ᆫ" and Unicode.get_medial_vowel(last) == "ᅡ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.remove_final_consonant(last),
          tense: @past_written_tense,
          sub_type: @regular
        }

      Unicode.get_final_consonant(last) == "ᆯ" and Unicode.get_medial_vowel(last) == "ᅡ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.remove_final_consonant(last),
          tense: @future_tense,
          sub_type: @regular
        }

      Unicode.get_final_consonant(last) == "ᆷ" and Unicode.get_medial_vowel(last) == "ᅡ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.remove_final_consonant(last),
          tense: @nominal_tense,
          sub_type: @regular
        }

      true ->
        nil
    end
  end

  @spec conjugate_eu(tuple(), tuple()) :: list
  defp conjugate_eu({last_remaining, last}, {second_last_remaining, second_last}) do
    cond do
      Unicode.get_final_consonant(second_last) == "ᆻ" and second_last != "있" ->
        second_last = Unicode.remove_final_consonant(second_last)

        cond do
          Unicode.get_medial_vowel(second_last) == "ᅥ" ->
            %Conjugated{
              word: last_remaining <> last,
              conjugated: second_last_remaining <> Unicode.change_medial_vowel(second_last, "ᅳ"),
              tense: @past_tense,
              sub_type: @regular
            }

          true ->
            nil
        end

      Unicode.get_final_consonant(last) == nil and Unicode.get_medial_vowel(last) == "ᅥ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.change_medial_vowel(last, "ᅳ"),
          tense: @present_tense,
          sub_type: @regular
        }

      Unicode.get_final_consonant(last) == "ᆸ" and Unicode.get_medial_vowel(last) == "ᅳ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.remove_final_consonant(last),
          tense: @present_formal_tense,
          sub_type: @regular
        }

      Unicode.get_final_consonant(last) == "ᆫ" and Unicode.get_medial_vowel(last) == "ᅳ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.remove_final_consonant(last),
          tense: @past_written_tense,
          sub_type: @regular
        }

      Unicode.get_final_consonant(last) == "ᆯ" and Unicode.get_medial_vowel(last) == "ᅳ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.remove_final_consonant(last),
          tense: @future_tense,
          sub_type: @regular
        }

      Unicode.get_final_consonant(last) == "ᆷ" and Unicode.get_medial_vowel(last) == "ᅳ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.remove_final_consonant(last),
          tense: @nominal_tense,
          sub_type: @regular
        }

      true ->
        nil
    end
  end

  @spec conjugate_rieul(tuple(), tuple()) :: list
  defp conjugate_rieul({last_remaining, last}, {_second_last_remaining, _second_last}) do
    cond do
      Unicode.get_final_consonant(last) == "ᆸ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.change_final_consonant(last, "ᆯ"),
          tense: @present_formal_tense,
          sub_type: @regular
        }

      Unicode.get_final_consonant(last) == "ᆫ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.change_final_consonant(last, "ᆯ"),
          tense: @past_written_tense,
          sub_type: @regular
        }

      Unicode.get_final_consonant(last) == nil ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.change_final_consonant(last, "ᆯ"),
          tense: @imperative_tense,
          sub_type: @regular
        }

      Unicode.get_final_consonant(last) == "ᆱ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.change_final_consonant(last, "ᆯ"),
          tense: @nominal_tense,
          sub_type: @regular
        }

      true ->
        nil
    end
  end

  @spec conjugate_u(tuple(), tuple()) :: list
  defp conjugate_u({last_remaining, last}, {_second_last_remaining, _second_last}) do
    cond do
      Unicode.get_medial_vowel(last) == "ᅯ" and Unicode.get_final_consonant(last) == "ᆻ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.change_medial_vowel(Unicode.remove_final_consonant(last), "ᅮ"),
          tense: @past_tense,
          sub_type: @regular
        }

      Unicode.get_medial_vowel(last) == "ᅯ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.change_medial_vowel(last, "ᅮ"),
          tense: @present_tense,
          sub_type: @regular
        }

      Unicode.get_final_consonant(last) == "ᆫ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.remove_final_consonant(last),
          tense: @past_written_tense,
          sub_type: @regular
        }

      Unicode.get_final_consonant(last) == "ᆯ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.remove_final_consonant(last),
          tense: @future_tense,
          sub_type: @regular
        }

      Unicode.get_final_consonant(last) == "ᆸ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.remove_final_consonant(last),
          tense: @present_formal_tense,
          sub_type: @regular
        }

      Unicode.get_final_consonant(last) == "ᆷ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.remove_final_consonant(last),
          tense: @nominal_tense,
          sub_type: @regular
        }

      true ->
        nil
    end
  end

  @spec conjugate_past(tuple(), tuple()) :: list
  defp conjugate_past({last_remaining, last}, {_second_last_remaining, _second_last}) do
    cond do
      Unicode.get_final_consonant(last) == "ᆻ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.remove_final_consonant(last),
          tense: @past_tense,
          sub_type: @regular
        }

      true ->
        nil
    end
  end

  @spec conjugate_irregular(String.t()) :: list
  def conjugate_irregular(word) when byte_size(word) == 0 do
    []
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

  @spec conjugate_irregular(String.t()) :: list
  def conjugate_irregular(_word) do
    []
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
      [conjugate_irregular_bieup(last, second_last)]
    ]
    |> List.flatten()
    |> Enum.filter(fn x -> x != nil end)
    |> Enum.uniq()
  end

  @spec conjugate_irregular_dieut(tuple(), tuple()) :: list
  defp conjugate_irregular_dieut({last_remaining, last}, {_second_last_remaining, _second_last}) do
    cond do
      Unicode.get_final_consonant(last) == "ᆯ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.change_final_consonant(last, "ᆮ"),
          tense: @present_tense,
          sub_type: @irregular
        }

      Unicode.get_final_consonant(last) == "ᆫ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.change_final_consonant(last, "ᆮ"),
          tense: @past_written_tense,
          sub_type: @irregular
        }

      Unicode.get_final_consonant(last) == "ᆸ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.change_final_consonant(last, "ᆮ"),
          tense: @present_formal_tense,
          sub_type: @irregular
        }

      true ->
        nil
    end
  end

  @spec conjugate_irregular_rieul(tuple(), tuple()) :: list
  defp conjugate_irregular_rieul({last_remaining, last}, {_second_last_remaining, _second_last}) do
    cond do
      Unicode.get_final_consonant(last) == "ᆫ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.change_final_consonant(last, "ᆯ"),
          tense: @past_written_tense,
          sub_type: @irregular
        }

      Unicode.get_final_consonant(last) == "ᆸ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.change_final_consonant(last, "ᆯ"),
          tense: @present_formal_tense,
          sub_type: @irregular
        }

      Unicode.get_final_consonant(last) == nil ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.change_final_consonant(last, "ᆯ"),
          tense: @imperative_tense,
          sub_type: @irregular
        }

      Unicode.get_final_consonant(last) == "ᆱ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.change_final_consonant(last, "ᆯ"),
          tense: @nominal_tense,
          sub_type: @irregular
        }

      true ->
        nil
    end
  end

  @spec conjugate_irregular_rieul_eu(tuple(), tuple()) :: list
  defp conjugate_irregular_rieul_eu({last_remaining, last}, {second_last_remaining, second_last}) do
    cond do
      last == "라" and Unicode.get_final_consonant(second_last) == "ᆯ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: second_last_remaining <> Unicode.remove_final_consonant(second_last) <> "르",
          tense: @present_tense,
          sub_type: @irregular
        }

      last == "른" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.remove_final_consonant(last),
          tense: @past_written_tense,
          sub_type: @irregular
        }

      last == "랐" and Unicode.get_final_consonant(second_last) == "ᆯ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: second_last_remaining <> Unicode.remove_final_consonant(second_last) <> "르",
          tense: @past_tense,
          sub_type: @irregular
        }

      last == "를" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> "르",
          tense: @future_tense,
          sub_type: @irregular
        }

      last == "릅" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> "르",
          tense: @present_formal_tense,
          sub_type: @irregular
        }

      last == "름" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> "르",
          tense: @nominal_tense,
          sub_type: @irregular
        }

      true ->
        nil
    end
  end

  @spec conjugate_irregular_sieut(tuple(), tuple()) :: list
  defp conjugate_irregular_sieut({last_remaining, last}, {_second_last_remaining, _second_last}) do
    cond do
      Unicode.get_final_consonant(last) == nil ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.change_final_consonant(last, "ᆺ"),
          tense: @present_tense,
          sub_type: @irregular
        }

      true ->
        nil
    end
  end

  @spec conjugate_irregular_hieuh_o(tuple(), tuple()) :: list
  defp conjugate_irregular_hieuh_o({last_remaining, last}, {_second_last_remaining, _second_last}) do
    cond do
      Unicode.get_final_consonant(last) == "ᆻ" and Unicode.get_medial_vowel(last) == "ᅢ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.change_final_consonant(Unicode.change_medial_vowel(last, "ᅥ"), "ᇂ"),
          tense: @past_tense,
          sub_type: @irregular
        }

      Unicode.get_final_consonant(last) == nil and Unicode.get_medial_vowel(last) == "ᅢ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.change_final_consonant(Unicode.change_medial_vowel(last, "ᅥ"), "ᇂ"),
          tense: @present_tense,
          sub_type: @irregular
        }

      Unicode.get_final_consonant(last) == "ᆯ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.change_final_consonant(Unicode.change_medial_vowel(last, "ᅥ"), "ᇂ"),
          tense: @future_tense,
          sub_type: @irregular
        }

      Unicode.get_final_consonant(last) == "ᆷ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.change_final_consonant(Unicode.change_medial_vowel(last, "ᅥ"), "ᇂ"),
          tense: @nominal_tense,
          sub_type: @irregular
        }

      Unicode.get_final_consonant(last) == nil ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.change_final_consonant(Unicode.change_medial_vowel(last, "ᅥ"), "ᇂ"),
          tense: @imperative_tense,
          sub_type: @irregular
        }

      true ->
        nil
    end
  end

  @spec conjugate_irregular_hieuh_a(tuple(), tuple()) :: list
  defp conjugate_irregular_hieuh_a({last_remaining, last}, {_second_last_remaining, _second_last}) do
    cond do
      Unicode.get_final_consonant(last) == "ᆻ" and Unicode.get_medial_vowel(last) == "ᅢ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.change_final_consonant(Unicode.change_medial_vowel(last, "ᅡ"), "ᇂ"),
          tense: @past_tense,
          sub_type: @irregular
        }

      Unicode.get_final_consonant(last) == nil and Unicode.get_medial_vowel(last) == "ᅢ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.change_final_consonant(Unicode.change_medial_vowel(last, "ᅡ"), "ᇂ"),
          tense: @present_tense,
          sub_type: @irregular
        }

      Unicode.get_final_consonant(last) == "ᆯ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.change_final_consonant(Unicode.change_medial_vowel(last, "ᅡ"), "ᇂ"),
          tense: @future_tense,
          sub_type: @irregular
        }

      Unicode.get_final_consonant(last) == "ᆷ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.change_final_consonant(Unicode.change_medial_vowel(last, "ᅡ"), "ᇂ"),
          tense: @nominal_tense,
          sub_type: @irregular
        }

      Unicode.get_final_consonant(last) == nil ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.change_final_consonant(Unicode.change_medial_vowel(last, "ᅡ"), "ᇂ"),
          tense: @imperative_tense,
          sub_type: @irregular
        }

      true ->
        nil
    end
  end

  @spec conjugate_irregular_bieup(tuple(), tuple()) :: list
  defp conjugate_irregular_bieup({last_remaining, last}, {_second_last_remaining, _second_last}) do
    cond do
      Unicode.get_final_consonant(last) == nil ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.change_final_consonant(last, "ᆸ"),
          tense: @present_tense,
          sub_type: @irregular
        }

      true ->
        nil
    end
  end

  @spec conjugate_passive(String.t()) :: list
  def conjugate_passive(word) when byte_size(word) == 0 do
    []
  end

  @spec conjugate_passive(String.t()) :: list
  def conjugate_passive(word) when byte_size(word) == 3 do
    conjugate_passive({"", word}, {"", word})
  end

  @spec conjugate_passive(String.t()) :: list
  def conjugate_passive(word) when byte_size(word) == 6 do
    conjugate_passive(String.split_at(word, -1), {"", String.first(word)})
  end

  @spec conjugate_passive(String.t()) :: list
  def conjugate_passive(word) when byte_size(word) > 6 do
    conjugate_passive(String.split_at(word, -1), String.split_at(String.slice(word, 0..-2), -1))
  end

  @spec conjugate_passive(String.t()) :: list
  def conjugate_passive(_word) do
    []
  end

  @spec conjugate_passive(tuple(), tuple()) :: list
  def conjugate_passive(last, second_last) do
    [
      [conjugate_passive_ieung_ee(last, second_last)]
    ]
    |> List.flatten()
    |> Enum.filter(fn x -> x != nil end)
    |> Enum.uniq()
  end

  @spec conjugate_passive_ieung_ee(tuple(), tuple()) :: list
  defp conjugate_passive_ieung_ee({last_remaining, last}, {_second_last_remaining, _second_last}) do
    cond do
      Unicode.get_medial_vowel(last) == "ᅱ" and Unicode.get_final_consonant(last) == nil ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.change_medial_vowel(Unicode.remove_final_consonant(last), "ᅮ"),
          tense: @present_tense,
          sub_type: @passive
        }

      Unicode.get_medial_vowel(last) == "ᅱ" and Unicode.get_final_consonant(last) == "ᆫ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.change_medial_vowel(Unicode.remove_final_consonant(last), "ᅮ"),
          tense: @past_written_tense,
          sub_type: @passive
        }

      Unicode.get_medial_vowel(last) == "ᅱ" and Unicode.get_final_consonant(last) == "ᆸ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.change_medial_vowel(Unicode.remove_final_consonant(last), "ᅮ"),
          tense: @present_formal_tense,
          sub_type: @passive
        }

      Unicode.get_medial_vowel(last) == "ᅱ" and Unicode.get_final_consonant(last) == "ᆯ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.change_medial_vowel(Unicode.remove_final_consonant(last), "ᅮ"),
          tense: @future_tense,
          sub_type: @passive
        }

      Unicode.get_medial_vowel(last) == "ᅱ" and Unicode.get_final_consonant(last) == "ᆷ" ->
        %Conjugated{
          word: last_remaining <> last,
          conjugated: last_remaining <> Unicode.change_medial_vowel(Unicode.remove_final_consonant(last), "ᅮ"),
          tense: @nominal_tense,
          sub_type: @passive
        }

      true ->
        nil
    end
  end
end
