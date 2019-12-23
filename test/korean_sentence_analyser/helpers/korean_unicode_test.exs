defmodule KoreanUnicodeTest do
  use ExUnit.Case
  import AssertValue
  alias KoreanSentenceAnalyser.Helpers.KoreanUnicode

  describe "We can split a sentence - " do
    test "투표......당신의 소중한  한표....ㅋㅋ" do
      assert_value(KoreanUnicode.split("투표......당신의 소중한  한표....ㅋㅋ") == ["투표", "당신의", "소중한", "한표"])
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
end
