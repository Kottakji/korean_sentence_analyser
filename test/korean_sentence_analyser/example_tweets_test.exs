defmodule ExampleTweetsTest do
  use ExUnit.Case
  import AssertValue

  describe "Example tweets -" do
    test "투표......당신의 소중한  한표....ㅋㅋ" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("투표....... 당신의 소중한  한표 .... ㅋㅋ") == [
                     %{"specific_type" => "Noun", "token" => "투표", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "당신", "type" => "Noun"},
                     %{"specific_type" => "Adjective", "token" => "소중하다", "type" => "Adjective"},
                     %{"specific_type" => "Noun", "token" => "표", "type" => "Noun"}
                   ]
    end
  end
end
