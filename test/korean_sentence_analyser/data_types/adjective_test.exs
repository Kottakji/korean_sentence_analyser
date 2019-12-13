defmodule AdjectiveTest do
  use ExUnit.Case
  import AssertValue

  describe "We can find adjectives - " do
    test "가능하다" do
      assert_value(
        KoreanSentenceAnalyser.analyse_word("가능하다") == %{
          "specific_type" => "Adjective",
          "token" => "가능하다",
          "type" => "Adjective"
        }
      )
    end

    test "가능해" do
      assert_value(
        KoreanSentenceAnalyser.analyse_word("가능해") == %{
          "specific_type" => "Adjective",
          "token" => "가능하다",
          "type" => "Adjective"
        }
      )
    end
    
    @tag :now
    test "소중한" do
      assert_value(
        KoreanSentenceAnalyser.analyse_word("소중한") == %{
          "specific_type" => "Adjective",
          "token" => "소중하다",
          "type" => "Adjective"
        }
      )
    end
  end
end
