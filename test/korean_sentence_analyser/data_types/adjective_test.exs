defmodule AdjectiveTest do
  use ExUnit.Case
  import AssertValue
  alias KoreanSentenceAnalyser.DataTypes.Adjective

  describe "We can find adjectives - " do
    test "가능하다" do
      assert_value(
        KoreanSentenceAnalyser.analyse_sentence("가능하다") == [
          %{"specific_type" => "Adjective", "token" => "가능하다", "type" => "Adjective"}
        ]
      )
    end

    test "소중한" do
      assert_value(
        KoreanSentenceAnalyser.analyse_sentence("소중한") == [
          %{"specific_type" => "Adjective", "token" => "소중하다", "type" => "Adjective"}
        ]
      )
    end

    test "감미롭" do
      assert_value(
        KoreanSentenceAnalyser.analyse_sentence("감미롭") == [
          %{"specific_type" => "Adjective", "token" => "감미롭다", "type" => "Adjective"}
        ]
      )
    end
  end

  describe "We can find adjectives after removing the modifier - " do
    test "없어요" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("없어요") == [
                     %{"specific_type" => "Adjective", "token" => "없다", "type" => "Adjective"}
                   ]
    end
    
    test "아니야" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("아니야") == [%{"specific_type" => "Adjective", "token" => "아니다", "type" => "Adjective"}]
    end

    @tag :now
    test "아니다" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("아니다") == [%{"specific_type" => "Adjective", "token" => "아니다", "type" => "Adjective"}]
    end
  end

  describe "We should not match certain nouns to adjectives - " do
    test "강수지이라고" do
      assert_value(Adjective.find("강수지이라고") == nil)
    end
  end
end
