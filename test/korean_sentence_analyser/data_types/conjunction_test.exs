defmodule ConjunctionTest do
  use ExUnit.Case
  import AssertValue

  describe "We can find conjunctions - " do
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
