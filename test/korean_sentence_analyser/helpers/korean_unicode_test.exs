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
end
