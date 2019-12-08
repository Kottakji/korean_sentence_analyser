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

    @tag :current
    test "늘다" do
      assert_value(
        KoreanSentenceAnalyser.analyse_word("늘다") == %{
          "specific_type" => "Verb",
          "token" => "늘다",
          "type" => "Verb"
        }
      )
    end
  end
end
