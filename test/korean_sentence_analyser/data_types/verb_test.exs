defmodule VerbTest do
  use ExUnit.Case
  import AssertValue
  
  describe "We can find verbs - " do
    test "먹다" do
      assert_value(
        KoreanSentenceAnalyser.analyse_word("먹다") == %{
          "specific_type" => "Verb",
          "token" => "먹다",
          "type" => "Verb"
        }
      )
    end
    
    test "먹어" do
      assert_value(
        KoreanSentenceAnalyser.analyse_word("먹어") == %{
          "specific_type" => "Verb",
          "token" => "먹다",
          "type" => "Verb"
        }
      )
    end

    test "냈어" do
      assert_value(
        KoreanSentenceAnalyser.analyse_word("냈어") == %{
          "specific_type" => "Verb",
          "token" => "내다",
          "type" => "Verb"
        }
      )
    end

    test "늘다" do
      assert_value(
        KoreanSentenceAnalyser.analyse_word("늘다") == %{
          "specific_type" => "Verb",
          "token" => "늘다",
          "type" => "Verb"
        }
      )
    end

    test "해놓다" do
      assert_value(
        KoreanSentenceAnalyser.analyse_word("해놓다") == %{
          "specific_type" => "Verb",
          "token" => "하다",
          "type" => "Verb"
        }
      )
    end
    
    test "하시다" do
      assert_value(
        KoreanSentenceAnalyser.analyse_word("하시다") == %{
          "specific_type" => "Verb",
          "token" => "하다",
          "type" => "Verb"
        }
      )
    end

    test "하시겠어요" do
      assert_value(
        KoreanSentenceAnalyser.analyse_word("하시겠어요") == %{
          "specific_type" => "Verb",
          "token" => "하다",
          "type" => "Verb"
        }
      )
    end

    test "하시지오" do
      assert_value(
        KoreanSentenceAnalyser.analyse_word("하시지오") == %{
          "specific_type" => "Verb",
          "token" => "하다",
          "type" => "Verb"
        }
      )
    end
  end
end
