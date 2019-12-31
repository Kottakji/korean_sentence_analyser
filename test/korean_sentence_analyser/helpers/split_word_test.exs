defmodule SplitWordTest do
  use ExUnit.Case
  import AssertValue
  doctest KSA.SplitWord

  describe "We can find long words without spaces - " do
    test "성열이냐" do
      assert_value(
        KoreanSentenceAnalyser.analyse_sentence("성열이냐") == [
          %{"specific_type" => "Given name", "token" => "성열", "type" => "Substantive"}
        ]
      )
    end

    test "성규목은근길다" do
      assert_value(
        KoreanSentenceAnalyser.analyse_sentence("성규목은근길다") == [
          %{"specific_type" => "Given name", "token" => "성규", "type" => "Substantive"},
          %{"specific_type" => "Noun", "token" => "목", "type" => "Noun"},
          %{"specific_type" => "Noun", "token" => "은근", "type" => "Noun"},
          %{"specific_type" => "Adjective", "token" => "길다", "type" => "Adjective"}
        ]
      )
    end
  end
end
