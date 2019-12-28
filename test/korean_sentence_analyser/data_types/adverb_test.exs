defmodule AdverbTest do
  use ExUnit.Case
  import AssertValue
  doctest Adverb

  describe "We can find adverbs - " do
    test "가강히" do
      assert_value(
        KoreanSentenceAnalyser.analyse_sentence("가강히") == [
          %{"specific_type" => "Adverb", "token" => "가강히", "type" => "Adverb"}
        ]
      )
    end
  end
end
