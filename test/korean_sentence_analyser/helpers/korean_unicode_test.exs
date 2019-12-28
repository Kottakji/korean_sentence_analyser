defmodule KoreanUnicodeTest do
  use ExUnit.Case
  import AssertValue
  alias KoreanUnicode
  doctest KoreanUnicode
  
  # See https://en.wikipedia.org/wiki/Korean_language_and_computers#Hangul_in_Unicode
  describe "We can create a character from code points - " do
    test "한" do
      assert_value KoreanUnicode.create_from_code_points(18, 0, 4) == "한"
    end
    
    test "폴" do
      assert_value KoreanUnicode.create_from_code_points(17, 8, 8) == "폴"
    end
  end
  
  describe "We can change the final character in a word - " do
    test "그렇" do
      assert_value KoreanUnicode.change_final_consonant("그렇", "ᆫ") == "그런"
    end
    
    test "노랗" do
      assert_value KoreanUnicode.change_final_consonant("노랗", "ᆫ") == "노란"
    end
  end

  describe "We can remove the final character in a word - " do
    test "마실" do
      assert_value KoreanUnicode.remove_final_consonant("마실") == "마시"
    end
  end
  
  describe "We can split a sentence - " do
    test "투표......당신의 소중한  한표....ㅋㅋ" do
      assert_value(KoreanUnicode.split("투표......당신의 소중한  한표....ㅋㅋ") == ["투표", "당신의", "소중한", "한표"])
    end
    
    test "십ㅂ알" do
      assert_value(KoreanUnicode.split("십ㄱ알") == ["십알"])
    end
    
    # First character in unicode
    test "가" do
      assert_value(KoreanUnicode.split("가") == ["가"])
    end
    
    # Last character in unicode
    test "힣" do
      assert_value(KoreanUnicode.split("힣") == ["힣"])
    end
    
    test "" do
      assert_value(KoreanUnicode.split("") == "")
    end
  end
  
  describe "We can find if the character starts with a certain hangul - " do
    test "가" do
      assert_value(KoreanUnicode.starts_with?("가", "ᄀ") == true)
    end
    
    test "하" do
      assert_value(KoreanUnicode.starts_with?("하", "ᄒ") == true)
    end
    
    test "되" do
      assert_value(KoreanUnicode.starts_with?("되", "ᄃ") == true)
    end
    
    test "ᄄ" do
      assert_value(KoreanUnicode.starts_with?("되", "ᄄ") == false)
    end
    
    test "ㅎ" do
      assert_value(KoreanUnicode.starts_with?("ㅋ", "ㅎ") == false)
    end
    
    test "싸" do
      assert_value(KoreanUnicode.starts_with?("싸", "ᄊ") == true)
    end
  end
  
  
  describe "We can find if the character end with a certain hangul - " do
    test "씻" do
      assert_value(KoreanUnicode.ends_with_final?("씻", "ᆺ") == true)
    end
  end
  
  describe "We can change the final consonant of a word - " do
    test "노랗" do
      assert_value(KoreanUnicode.get_final_consonant("랗") == "ᇂ")
      assert_value(KoreanUnicode.change_final_consonant("노랗", "ᆫ") == "노란")
    end
  end
  
  describe "We can find initial consonants - " do
    test "한" do
      assert_value(KoreanUnicode.get_initial_code_point("한") == 18)
      assert_value(KoreanUnicode.get_initial_consonant("한") == "ᄒ")
    end
    
    test "폴" do
      assert_value(KoreanUnicode.get_initial_code_point("폴") == 17)
      assert_value(KoreanUnicode.get_initial_consonant("폴") == "ᄑ")
    end
  end
  
  describe "We can find medial vowels - " do
    test "한" do
      assert_value(KoreanUnicode.get_medial_code_point("한") == 0)
      assert_value(KoreanUnicode.get_medial_vowel("한") == "ᅡ")
    end
    
    test "폴" do
      assert_value(KoreanUnicode.get_medial_code_point("폴") == 8)
      assert_value(KoreanUnicode.get_medial_vowel("폴") == "ᅩ")
    end
  end
  
  describe "We can find final consonants - " do
    test "한" do
      assert_value(KoreanUnicode.get_final_code_point("한") == 4)
      assert_value(KoreanUnicode.get_final_consonant("한") == "ᆫ")
    end
    
    test "폴" do
      assert_value(KoreanUnicode.get_final_code_point("폴") == 8)
      assert_value(KoreanUnicode.get_final_consonant("폴") == "ᆯ")
    end
  end
end
