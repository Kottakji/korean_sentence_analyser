defmodule VerbTest do
  use ExUnit.Case
  import AssertValue
  doctest KSA.Verb

  describe "We can find verbs - " do
    test "먹다" do
      assert_value(
        KoreanSentenceAnalyser.analyse_sentence("먹다") == [
          %{"specific_type" => "Verb", "token" => "먹다", "type" => "Verb"}
        ]
      )
    end

    test "먹어" do
      assert_value(
        KoreanSentenceAnalyser.analyse_sentence("먹어") == [
          %{"specific_type" => "Verb", "token" => "먹다", "type" => "Verb"}
        ]
      )
    end

    test "냈어" do
      assert_value(
        KoreanSentenceAnalyser.analyse_sentence("냈어") == [
          %{"specific_type" => "Verb", "token" => "내다", "type" => "Verb"}
        ]
      )
    end

    test "늘다" do
      assert_value(KoreanSentenceAnalyser.analyse_sentence("늘다") == [%{"specific_type" => "Verb", "token" => "늘다", "type" => "Verb"}])
    end

    test "해놓다" do
      assert_value(
        KoreanSentenceAnalyser.analyse_sentence("해놓다") == [
          %{"specific_type" => "Verb", "token" => "하다", "type" => "Verb"}
        ]
      )
    end

    test "하시다" do
      assert_value(
        KoreanSentenceAnalyser.analyse_sentence("하시다") == [
          %{"specific_type" => "Verb", "token" => "하다", "type" => "Verb"}
        ]
      )
    end

    test "하시겠어요" do
      assert_value(
        KoreanSentenceAnalyser.analyse_sentence("하시겠어요") == [
          %{"specific_type" => "Verb", "token" => "하다", "type" => "Verb"}
        ]
      )
    end

    test "하시지오" do
      assert_value(
        KoreanSentenceAnalyser.analyse_sentence("하시지오") == [
          %{"specific_type" => "Verb", "token" => "하다", "type" => "Verb"}
        ]
      )
    end

    test "감사합니다" do
      assert_value(KoreanSentenceAnalyser.analyse_sentence("감사합니다") == [%{"specific_type" => "Mix", "token" => "감사하다", "type" => "Mix"}])
    end
  end

  describe "We can find verbs directly - " do
    test "지쳐요" do
      assert_value KSA.Verb.find("지쳐요") == %{"specific_type" => "Verb", "token" => "지치다", "type" => "Verb"}
    end

    test "마시다" do
      assert_value KSA.Verb.find("마시다") == %{"specific_type" => "Verb", "token" => "마시다", "type" => "Verb"}
    end

    test "만드는" do
      assert_value KSA.Verb.find("만드는") == %{"specific_type" => "Verb", "token" => "만들다", "type" => "Verb"}
    end

    test "매다는" do
      assert_value KSA.Verb.find("매다는") == %{"specific_type" => "Verb", "token" => "매달다", "type" => "Verb"}
    end

    test "만든" do
      assert_value KSA.Verb.find("만든") == %{"specific_type" => "Verb", "token" => "만들다", "type" => "Verb"}
    end
  end
end
