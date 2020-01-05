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
          %{"specific_type" => "Modifier", "token" => "한", "type" => "Modifier"},
          %{"specific_type" => "Noun", "token" => "표", "type" => "Noun"}
        ]
      )
    end

    test "성규목은근길다ㅏ 성열이냐 성규냐.." do
      # Improvement 은근 is not a noun, but an adjective
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
          %{"specific_type" => "Noun", "token" => "성", "type" => "Noun"},
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
      assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ오른ㄴ쪽손엨ㅋㅋㅋㅋ컄ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅁㅋㅋㅋㅋㅋㅋㅇㅋㅇㅋㅌㅌㅋㅋㅋ그거먼ㄴ데옄ㅋㅋㅋㅋㅋㅋㅋ") == [
                     %{"specific_type" => "Noun", "token" => "오른쪽", "type" => "Noun"},
                     %{"specific_type" => "Family name", "token" => "손", "type" => "Substantive"}
                   ]
    end

    test "@user 젠장 나는 이나라에 살아서 받는게 도대체 무엇이야" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 젠장 나는 이나라에 살아서 받는게 도대체 무엇이야") == [
                     %{"specific_type" => "Noun", "token" => "젠장", "type" => "Noun"},
                     %{"specific_type" => "Determiner", "token" => "나", "type" => "Determiner"},
                     %{"specific_type" => "Wikipedia title noun", "token" => "이나라", "type" => "Noun"},
                     %{"specific_type" => "Adjective", "token" => "살다", "type" => "Adjective"},
                     %{"specific_type" => "Verb", "token" => "받다", "type" => "Verb"},
                     %{"specific_type" => "Noun", "token" => "도대체", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "무엇", "type" => "Noun"}
                   ]
    end

    test "RT @user: [SS현장] '고열량-無표시' 한정판 햄버거… '알 면 안 먹습니다' http://link.com" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: [SS현장] '고열량-無표시' 한정판 햄버거… '알 면 안 먹습니다' http://link.com") == [
                     %{"specific_type" => "Noun", "token" => "현장", "type" => "Noun"},
                     %{"specific_type" => "Modifier", "token" => "고", "type" => "Modifier"},
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

    test "@user 1. 꽃밭에서-과거의 오르도와 미래의 산(초면)" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 1. 꽃밭에서-과거의 오르도와 미래의 산(초면)") == [
                     %{"specific_type" => "Noun", "token" => "꽃", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "밭", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "과거", "type" => "Noun"},
                     %{"specific_type" => "Verb", "token" => "오르다", "type" => "Verb"},
                     %{"specific_type" => "grammar", "token" => "와", "type" => "grammar"},
                     %{"specific_type" => "Noun", "token" => "미래", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "산", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "초면", "type" => "Noun"}
                   ]
    end

    test "@user 싫어. 이거 놔! (소름돋았는지 강하게 발버둥) 놔! 놓으란 말이야!(바둥바둥" do
      # Improvement correct 바둥바둥 to 버둥버둥
      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 싫어. 이거 놔! (소름돋았는지 강하게 발버둥) 놔! 놓으란 말이야!(바둥바둥") == [
                     %{"specific_type" => "Adjective", "token" => "싫다", "type" => "Adjective"},
                     %{"specific_type" => "Determiner", "token" => "이", "type" => "Determiner"},
                     %{"specific_type" => "Noun", "token" => "거", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "소름", "type" => "Noun"},
                     %{"specific_type" => "Adjective", "token" => "돋다", "type" => "Adjective"},
                     %{"specific_type" => "Adjective", "token" => "강하다", "type" => "Adjective"},
                     %{"specific_type" => "Noun", "token" => "발", "type" => "Noun"},
                     %{"specific_type" => "Verb", "token" => "놓다", "type" => "Verb"},
                     %{"specific_type" => "Verb", "token" => "말다", "type" => "Verb"},
                     %{"specific_type" => "Noun", "token" => "바", "type" => "Noun"}
                   ]
    end

    test "아놔.ㅋㅋ 중랑구는 뭔데.ㅋㅋ 강남3구에 낀다냐.ㅋㅋㅋ" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("아놔.ㅋㅋ 중랑구는 뭔데.ㅋㅋ 강남3구에 낀다냐.ㅋㅋㅋ") == [
                     %{"specific_type" => "Geolocation", "token" => "중랑구", "type" => "Noun"},
                     %{"specific_type" => "Modifier", "token" => "뭔", "type" => "Modifier"},
                     %{"specific_type" => "Noun", "token" => "데", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "강남", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "구", "type" => "Noun"},
                     %{"specific_type" => "Verb", "token" => "끼다", "type" => "Verb"}
                   ]
    end

    test "...계단의 핏자욱이..." do
      # 핏자욱 is a spelling error
      # 요우 is a co-worker
      # 생각한다면 is a verb
      # 수도 is grammar, what to do!?
      # 당했다 is a verb? 당하다
      assert_value KoreanSentenceAnalyser.analyse_sentence(
                     "...계단의 핏자욱이 쿠리야마 요우의 것이라고 생각한다면... 왜? 굳이 4층에서 3층으로 내려온걸까? 물론 올라갔을 수도 있지만. 4층에서 내려오던 범인과 마주쳤는데, 급습을 당했다?"
                   ) == [
                     %{"specific_type" => "Noun", "token" => "계단", "type" => "Noun"},
                     %{"specific_type" => "Foreign", "token" => "쿠리야마", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "요우", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "것", "type" => "Noun"},
                     %{"specific_type" => "Mix", "token" => "생각하다", "type" => "Mix"},
                     %{"specific_type" => "Noun", "token" => "왜", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "굳이", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "층", "type" => "Noun"},
                     %{"specific_type" => "Verb", "token" => "내려오다", "type" => "Verb"},
                     %{"specific_type" => "Adverb", "token" => "물론", "type" => "Adverb"},
                     %{"specific_type" => "Verb", "token" => "올라가다", "type" => "Verb"},
                     %{"specific_type" => "Noun", "token" => "수도", "type" => "Noun"},
                     %{"specific_type" => "Adjective", "token" => "있다", "type" => "Adjective"},
                     %{"specific_type" => "Noun", "token" => "범인", "type" => "Noun"},
                     %{"specific_type" => "grammar", "token" => "과", "type" => "grammar"},
                     %{"specific_type" => "Noun", "token" => "마주", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "급습", "type" => "Noun"},
                     %{"specific_type" => "Mix", "token" => "당하다", "type" => "Mix"}
                   ]
    end

    test "@user 십ㅂ알 궁상맞잖아! 걍 먹어!" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 십ㅂ알 궁상맞잖아! 걍 먹어!") == [
                     %{"specific_type" => "Profane", "token" => "씨발", "type" => "Noun"},
                     %{"specific_type" => "Adjective", "token" => "궁상맞다", "type" => "Adjective"},
                     %{"specific_type" => "Adverb", "token" => "걍", "type" => "Adverb"},
                     %{"specific_type" => "Verb", "token" => "먹다", "type" => "Verb"}
                   ]
    end

    test "@user 와ㅣ@!!!!!" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 와ㅣ@!!!!!") == [%{"specific_type" => "Adverb", "token" => "와", "type" => "Adverb"}]
    end

    test "iPhone용 The Tribez의 미션 `커피 나무.`을(를) 달성했습니다!  완료할 수 있을까요? http://link.com #iphone, #iphonegames, #gameinsight" do
      assert_value KoreanSentenceAnalyser.analyse_sentence(
                     "iPhone용 The Tribez의 미션 `커피 나무.`을(를) 달성했습니다!  완료할 수 있을까요? http://link.com #iphone, #iphonegames, #gameinsight"
                   ) == [
                     %{"specific_type" => "Noun", "token" => "용", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "의", "type" => "Noun"},
                     %{"specific_type" => "Entities", "token" => "미션", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "커피", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "나무", "type" => "Noun"},
                     %{"specific_type" => "Mix", "token" => "달성하다", "type" => "Mix"},
                     %{"specific_type" => "Mix", "token" => "완료하다", "type" => "Mix"}
                   ]
    end

    test "4. 지금인상 → 하앜.. 딘.. 하앜" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("4. 지금인상 → 하앜.. 딘.. 하앜") == [
                     %{"specific_type" => "Noun", "token" => "지금", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "인상", "type" => "Noun"},
                     %{"specific_type" => "Verb", "token" => "하다", "type" => "Verb"}
                   ]
    end

    test "아빠가 ..." do
      assert_value KoreanSentenceAnalyser.analyse_sentence(
                     "아빠가 새 휴대 전화를 구입하고 그 충전기는 아이폰이다~~ 그래서 아빠 감사합니다♥내가 그녀의 휴대 전화 케이스에 핑크 색상을 싫어하지만ㅎㅎ 하지만 나는 그것을 사용합니다ㅋㅋㅋㅋㅋㅋㅋㅋㅋ http://link.com"
                   ) == [
                     %{"specific_type" => "Noun", "token" => "아빠", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "새", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "휴대", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "전화", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "구입", "type" => "Noun"},
                     %{"specific_type" => "Determiner", "token" => "그", "type" => "Determiner"},
                     %{"specific_type" => "Wikipedia title noun", "token" => "충전기", "type" => "Noun"},
                     %{"specific_type" => "Entities", "token" => "아이폰", "type" => "Noun"},
                     %{"specific_type" => "Conjunction", "token" => "그래서", "type" => "Conjunction"},
                     %{"specific_type" => "Mix", "token" => "감사하다", "type" => "Mix"},
                     %{"specific_type" => "Entities", "token" => "그녀", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "케이스", "type" => "Noun"},
                     %{"specific_type" => "Wikipedia title noun", "token" => "핑크", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "색상", "type" => "Noun"},
                     %{"specific_type" => "Adjective", "token" => "싫어하다", "type" => "Adjective"},
                     %{"specific_type" => "Conjunction", "token" => "하지만", "type" => "Conjunction"},
                     %{"specific_type" => "Determiner", "token" => "나", "type" => "Determiner"},
                     %{"specific_type" => "Noun", "token" => "그것", "type" => "Noun"},
                     %{"specific_type" => "Mix", "token" => "사용하다", "type" => "Mix"}
                   ]
    end

    test "@user @user 아니다 이거 제가 잘못 가져온것 같아요 입학 찍기 입학 방어 이속 이속 공 이라는데요?" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user 아니다 이거 제가 잘못 가져온것 같아요 입학 찍기 입학 방어 이속 이속 공 이라는데요?") == [
                     %{"specific_type" => "Adjective", "token" => "아니다", "type" => "Adjective"},
                     %{"specific_type" => "Determiner", "token" => "이", "type" => "Determiner"},
                     %{"specific_type" => "Noun", "token" => "거", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "제", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "잘못", "type" => "Noun"},
                     %{"specific_type" => "Verb", "token" => "가져오다", "type" => "Verb"},
                     %{"specific_type" => "Adjective", "token" => "같다", "type" => "Adjective"},
                     %{"specific_type" => "Noun", "token" => "입학", "type" => "Noun"},
                     %{"specific_type" => "Entities", "token" => "찍기", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "방어", "type" => "Noun"},
                     %{"specific_type" => "Wikipedia title noun", "token" => "이속", "type" => "Noun"},
                     %{"specific_type" => "Family name", "token" => "공", "type" => "Substantive"},
                     %{"specific_type" => "Adjective", "token" => "이다", "type" => "Adjective"}
                   ]
    end

    test "#팁 #매드라이프 노란 로봇장난감을 주면 뭔가를 잘 물어옵니다." do
      assert_value KoreanSentenceAnalyser.analyse_sentence("#팁 #매드라이프 노란 로봇장난감을 주면 뭔가를 잘 물어옵니다.") == [
                     %{"specific_type" => "Foreign", "token" => "팁", "type" => "Noun"},
                     %{"specific_type" => "Wikipedia title noun", "token" => "매드라이프", "type" => "Noun"},
                     %{"specific_type" => "Adjective", "token" => "노랗다", "type" => "Adjective"},
                     %{"specific_type" => "Noun", "token" => "로봇", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "장난감", "type" => "Noun"},
                     %{"specific_type" => "Verb", "token" => "주다", "type" => "Verb"},
                     %{"specific_type" => "Noun", "token" => "뭔가", "type" => "Noun"},
                     %{"specific_type" => "Adverb", "token" => "잘", "type" => "Adverb"},
                     %{"specific_type" => "Verb", "token" => "물다", "type" => "Verb"}
                   ]
    end

    test "@user 파리투나잇~♬♪ (흥얼흥얼)" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 파리투나잇~♬♪ (흥얼흥얼)") == [
                     %{"specific_type" => "Noun", "token" => "파리", "type" => "Noun"},
                     %{"specific_type" => "Entities", "token" => "투나잇", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "흥얼흥얼", "type" => "Noun"}
                   ]
    end

    test "@user ㅇㅁㅇ..?세개를다섞는다..이말입니가..?" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅇㅁㅇ..?세개를다섞는다..이말입니가..?") == [
                     %{"specific_type" => "Modifier", "token" => "세", "type" => "Modifier"},
                     %{"specific_type" => "Noun", "token" => "개", "type" => "Noun"},
                     %{"specific_type" => "Adverb", "token" => "다", "type" => "Adverb"},
                     %{"specific_type" => "Verb", "token" => "섞다", "type" => "Verb"},
                     %{"specific_type" => "Determiner", "token" => "이", "type" => "Determiner"},
                     %{"specific_type" => "Noun", "token" => "말", "type" => "Noun"},
                     %{"specific_type" => "Verb", "token" => "입니다", "type" => "Verb"}
                   ]
    end

    test "RT @user: 악!!!!!!!! 이진기!!!!!!! 조아해!!!!! http://link.com" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 악!!!!!!!! 이진기!!!!!!! 조아해!!!!! http://link.com") == [
                     %{"specific_type" => "Noun", "token" => "악", "type" => "Noun"},
                     %{"specific_type" => "Foreign", "token" => "이진기", "type" => "Noun"},
                     %{"specific_type" => "Modifier", "token" => "조", "type" => "Modifier"},
                     %{"specific_type" => "Wikipedia title noun", "token" => "아해", "type" => "Noun"}
                   ]
    end
  end
end
