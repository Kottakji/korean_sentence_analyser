defmodule TypoTest do
  use ExUnit.Case
  import AssertValue
  alias Typo

  describe "We can transform typo's - " do
    test "십알" do
      assert_value(Typo.find("십알") == "씨발")
    end

    test "십알새끼" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("십알새끼") == [
                     %{"specific_type" => "Profane", "token" => "씨발", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "새끼", "type" => "Noun"}
                   ]
    end
  end
end
