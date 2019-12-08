defmodule NormalizeTest do
  use ExUnit.Case
  import AssertValue
  import KoreanSentenceAnalyser.Normalize

  describe "We can normalize words - " do
    test "가능하다" do
      assert_value(normalize("가능하다") == "가능하")
    end

    test "가능되다" do
      assert_value(normalize("가능되다") == "가능되")
    end

    test "가능한다" do
      assert_value(normalize_destructive("가능한다") == "가능하")
    end

    test "가능해" do
      assert_value(normalize_destructive("가능해") == "가능하")
    end

    test "가능할텐데요" do
      assert_value(normalize_destructive("가능할텐데요") == "가능하")
    end

    test "가능해요" do
      assert_value(normalize_destructive("가능해요") == "가능하")
    end

    test "가능돼" do
      assert_value(normalize_destructive("가능돼") == "가능되")
    end

    test "가능돼요" do
      assert_value(normalize_destructive("가능돼요") == "가능되")
    end

    test "맛있다" do
      assert_value(normalize_destructive("맛있다") == "맛있")
    end

    test "맛없다" do
      assert_value(normalize_destructive("맛없다") == "맛없")
    end
  end
end
