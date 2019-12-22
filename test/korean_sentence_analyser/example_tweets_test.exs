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

    test "@user ㄱ..그냥ㅋㅋㅋ" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㄱ..그냥ㅋㅋㅋ") == [
                     %{"specific_type" => "Noun", "token" => "그냥", "type" => "Noun"}
                   ]
    end

    test "카세료보다 당신이 더 대단하다고!!!!" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("카세료보다 당신이 더 대단하다고!!!!") == [
                     %{"specific_type" => "Wikipedia title noun", "token" => "카세료", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "당신", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "더", "type" => "Noun"},
                     %{"specific_type" => "Adjective", "token" => "대단하다", "type" => "Adjective"}
                   ]
    end

    test "Long string ㅋㅋㅋㅋㅋ" do
      assert_value KoreanSentenceAnalyser.analyse_sentence(
                     "@user ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ오른ㄴ쪽손엨ㅋㅋㅋㅋ컄ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅁㅋㅋㅋㅋㅋㅋㅇㅋㅇㅋㅌㅌㅋㅋㅋ그거먼ㄴ데옄ㅋㅋㅋㅋㅋㅋㅋ"
                   ) == [
                     %{"specific_type" => "Noun", "token" => "오른", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "쪽", "type" => "Noun"},
                     %{"specific_type" => "Family name", "token" => "손", "type" => "Substantive"},
                     %{"specific_type" => "Noun", "token" => "그거", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "데", "type" => "Noun"}
                   ]
    end

    test "@user 젠장 나는 이나라에 살아서 받는게 도대체 무엇이야" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 젠장 나는 이나라에 살아서 받는게 도대체 무엇이야") == [
                     %{"specific_type" => "Noun", "token" => "젠장", "type" => "Noun"},
                     %{"specific_type" => "Verb", "token" => "나다", "type" => "Verb"},
                     %{"specific_type" => "Wikipedia title noun", "token" => "이나라", "type" => "Noun"},
                     %{"specific_type" => "Adjective", "token" => "살다", "type" => "Adjective"},
                     %{"specific_type" => "Verb", "token" => "받다", "type" => "Verb"},
                     %{"specific_type" => "Noun", "token" => "도대체", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "무엇", "type" => "Noun"}
                   ]
    end

    test "RT @user: [SS현장] '고열량-無표시' 한정판 햄버거… '알 면 안 먹습니다' http://link.com" do
      assert_value KoreanSentenceAnalyser.analyse_sentence(
                     "RT @user: [SS현장] '고열량-無표시' 한정판 햄버거… '알 면 안 먹습니다' http://link.com"
                   ) == [
                     %{"specific_type" => "Noun", "token" => "현장", "type" => "Noun"},
                     # TODO 고열량
                     %{"specific_type" => "Noun", "token" => "열량", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "표시", "type" => "Noun"},
                     %{"specific_type" => "Wikipedia title noun", "token" => "한정판", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "햄버거", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "알", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "면", "type" => "Noun"},
                     %{"specific_type" => "Family name", "token" => "안", "type" => "Substantive"},
                     %{"specific_type" => "Verb", "token" => "먹다", "type" => "Verb"}
                   ]
    end
  end
end
