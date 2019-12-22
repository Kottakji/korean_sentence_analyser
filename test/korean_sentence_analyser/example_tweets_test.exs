defmodule ExampleTweetsTest do
  use ExUnit.Case
  import AssertValue

  describe "Example tweets -" do
    test "투표......당신의 소중한  한표....ㅋㅋ" do
      assert_value(
        KoreanSentenceAnalyser.analyse_sentence("투표....... 당신의 소중한  한표 .... ㅋㅋ") == [
          %{"specific_type" => "Noun", "token" => "투표", "type" => "Noun"},
          %{"specific_type" => "Noun", "token" => "당신", "type" => "Noun"},
          %{"specific_type" => "Adjective", "token" => "소중하다", "type" => "Adjective"},
          %{"specific_type" => "Noun", "token" => "표", "type" => "Noun"}
        ]
      )
    end

    test "성규목은근길다ㅏ 성열이냐 성규냐.." do
      # 성규 = name, 목 = noun, 은근 = adjective? , 길다 = verb
      # TODO 은근 is not a noun, but an adjective
      assert_value(
        KoreanSentenceAnalyser.analyse_sentence("성규목은근길다ㅏ 성열이냐 성규냐..") == [
          %{"specific_type" => "Given name", "token" => "성규", "type" => "Substantive"},
          %{"specific_type" => "Noun", "token" => "목", "type" => "Noun"},
          %{"specific_type" => "Noun", "token" => "은근", "type" => "Noun"},
          %{"specific_type" => "Adjective", "token" => "길다", "type" => "Adjective"},
          %{"specific_type" => "Given name", "token" => "성열", "type" => "Substantive"}
        ]
      )
    end

    test "@user 어....없어요? 성이 형님..." do
      assert_value(
        KoreanSentenceAnalyser.analyse_sentence("@user 어....없어요? 성이 형님...") == [
          %{"specific_type" => "Adjective", "token" => "없다", "type" => "Adjective"},
          %{"specific_type" => "Adjective", "token" => "성하다", "type" => "Adjective"},
          %{"specific_type" => "Noun", "token" => "형님", "type" => "Noun"}
        ]
      )
    end
  end
end
