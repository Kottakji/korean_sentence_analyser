defmodule ExampleTweetsTest do
  use ExUnit.Case
  import AssertValue

  describe "Example tweets -" do
    @tag :current
    # 소중한 fix for adjectives
    # 한표, dunno what that is
    test "투표......당신의 소중한  한표....ㅋㅋ" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("투표....... 당신의 소중한  한표 .... ㅋㅋ")
    end
  end
end
