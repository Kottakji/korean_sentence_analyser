defmodule SubstantiveTest do
  use ExUnit.Case
  import AssertValue
  doctest KSA.Substantive

  describe "We can find substantives - " do
    test "경수" do
      assert_value(KoreanSentenceAnalyser.analyse_sentence("경수") == [%{"specific_type" => "Given name", "token" => "경수", "type" => "Substantive"}])
    end

    test "박" do
      assert_value(KoreanSentenceAnalyser.analyse_sentence("박") == [%{"specific_type" => "Family name", "token" => "박", "type" => "Substantive"}])
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
