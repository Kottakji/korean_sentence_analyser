defmodule SubstantiveTest do
  use ExUnit.Case
  import AssertValue

  describe "We can find substantives - " do
    test "예진" do
      assert_value(
        KoreanSentenceAnalyser.analyse_sentence("예진") == [
          %{"specific_type" => "Given name", "token" => "예진", "type" => "Substantive"}
        ]
      )
    end

    test "이" do
      assert_value(
        KoreanSentenceAnalyser.analyse_sentence("이") == [
          %{"specific_type" => "Family name", "token" => "이", "type" => "Substantive"}
        ]
      )
    end

    test "성규냐 - which includes a josa" do
      assert_value(
        KoreanSentenceAnalyser.analyse_sentence("성규냐") == [
          %{"specific_type" => "Given name", "token" => "성규", "type" => "Substantive"}
        ]
      )
    end
  end
end
