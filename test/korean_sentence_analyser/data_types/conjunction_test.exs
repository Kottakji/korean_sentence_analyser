defmodule ConjunctionTest do
  use ExUnit.Case
  import AssertValue
  doctest KSA.Conjunction

  describe "We can find conjunctions - " do
    test "하지만" do
      assert_value(KoreanSentenceAnalyser.analyse_sentence("하지만") == [%{"specific_type" => "Conjunction", "token" => "하지만", "type" => "Conjunction"}])
    end
    test "그럼" do
      assert_value(
        KoreanSentenceAnalyser.analyse_sentence("그럼") == [
          %{"specific_type" => "Conjunction", "token" => "그럼", "type" => "Conjunction"}
        ]
      )
    end

    test "이러다가" do
      assert_value(
        KoreanSentenceAnalyser.analyse_sentence("이러다가") == [
          %{"specific_type" => "Conjunction", "token" => "이러다가", "type" => "Conjunction"}
        ]
      )
    end
  end
end
