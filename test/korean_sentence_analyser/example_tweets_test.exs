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
      assert_value KoreanSentenceAnalyser.analyse_sentence(
                     "@user ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ오른ㄴ쪽손엨ㅋㅋㅋㅋ컄ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅁㅋㅋㅋㅋㅋㅋㅇㅋㅇㅋㅌㅌㅋㅋㅋ그거먼ㄴ데옄ㅋㅋㅋㅋㅋㅋㅋ"
                   ) == [
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
      assert_value KoreanSentenceAnalyser.analyse_sentence(
                     "RT @user: [SS현장] '고열량-無표시' 한정판 햄버거… '알 면 안 먹습니다' http://link.com"
                   ) == [
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
      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 와ㅣ@!!!!!") == [
                     %{"specific_type" => "Adverb", "token" => "와", "type" => "Adverb"}
                   ]
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
                     %{"specific_type" => "Verb", "token" => "감사하다", "type" => "Verb"},
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
      assert_value KoreanSentenceAnalyser.analyse_sentence(
                     "@user @user 아니다 이거 제가 잘못 가져온것 같아요 입학 찍기 입학 방어 이속 이속 공 이라는데요?"
                   ) == [
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
    
#    test "RT @user: 악!!!!!!!! 이진기!!!!!!! 조아해!!!!! http://link.com" do
#      assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 악!!!!!!!! 이진기!!!!!!! 조아해!!!!! http://link.com")
#    end
    #    test "@user @user 누나다! 누나 안아줘어-" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user 누나다! 누나 안아줘어-")
    #    end
    #    test "@user 끕끕. 태일이 나쁘어. (;_; (아구몬 유경험자)" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 끕끕. 태일이 나쁘어. (;_; (아구몬 유경험자)")
    #    end
    #    test "@user @user 나 벌써 기분져타...시오야끼+맥주+해변=성우" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user 나 벌써 기분져타...시오야끼+맥주+해변=성우")
    #    end
    #    test "@user 잘해쪄 이쁘니!!!!!&gt;3&lt;!!!(쭈압" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 잘해쪄 이쁘니!!!!!&gt;3&lt;!!!(쭈압")
    #    end
    #    test "타이가 엄마 느낌 강한 건 아는데 이새끼가 병신같은면이 있고 그래도 상대방 존중..ㅇㅇ 결ㄷ단력은 좋은 놈이야. 자기 부모님한테 사망통ㅇㅂㅈㅣ..." do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("타이가 엄마 느낌 강한 건 아는데 이새끼가 병신같은면이 있고 그래도 상대방 존중..ㅇㅇ 결ㄷ단력은 좋은 놈이야. 자기 부모님한테 사망통ㅇㅂㅈㅣ...")
    #    end
    #    test "오늘은 날씨가 맑습니다. 건강을 위해서라도 가볍게 5km 조깅 어떠십니까?" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("오늘은 날씨가 맑습니다. 건강을 위해서라도 가볍게 5km 조깅 어떠십니까?")
    #    end
    #    test "@user 나는 안가지롱~♪" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 나는 안가지롱~♪")
    #    end
    #    test "싸인회가? 말아? 아씨 존나 고민되네... 가고는싶은데 돈이걸리고 안가자니 가고싶고... 누가 통쾌하게 해답좀... 싸인회 안가도 맘 편해질수 있게.. 납득좀 시켜줘요" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("싸인회가? 말아? 아씨 존나 고민되네... 가고는싶은데 돈이걸리고 안가자니 가고싶고... 누가 통쾌하게 해답좀... 싸인회 안가도 맘 편해질수 있게.. 납득좀 시켜줘요")
    #    end
    #    test "@user 어쩌다보니 저렇게 되었더라구요ㅇㅅㅇ;;;" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 어쩌다보니 저렇게 되었더라구요ㅇㅅㅇ;;;")
    #    end
    #    test "@user …눈뜨고 그런 사람은 한명 알고 있는데… 어쨌든. 적어도 Mr Rogers는 쌍방향이니까…" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("@user …눈뜨고 그런 사람은 한명 알고 있는데… 어쨌든. 적어도 Mr Rogers는 쌍방향이니까…")
    #    end
    #    test "@user ㅋㅋㅋ독일얘기 많이나온다 했더니 비도스지탓이였냐고요 비도스지가 더 좋아질것만같군요^^;; 미친 머쓰시나 했더니 그림보는썰 으 시발 어머니 존나사랑하는 시츄에 걸맞는 차가움 존나 좋습니다 이래야 팬리아지 그와중에 최고극장의 신입연주갘" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅋㅋㅋ독일얘기 많이나온다 했더니 비도스지탓이였냐고요 비도스지가 더 좋아질것만같군요^^;; 미친 머쓰시나 했더니 그림보는썰 으 시발 어머니 존나사랑하는 시츄에 걸맞는 차가움 존나 좋습니다 이래야 팬리아지 그와중에 최고극장의 신입연주갘")
    #    end
    #    test "@user 꿀벌도 짱귀라서 뭘골라야할지... 애덜 진짜 애기도아니고 그나이에 왜케 귀엽게노는지 멀겟....ㅜㅜ" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 꿀벌도 짱귀라서 뭘골라야할지... 애덜 진짜 애기도아니고 그나이에 왜케 귀엽게노는지 멀겟....ㅜㅜ")
    #    end
    #    test "일년치 모욕 다 들은 기분이었음 세상이 붕괴하는 듯한 이 기분 이 처참함 이 암담함 내가 호구따위보다" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("일년치 모욕 다 들은 기분이었음 세상이 붕괴하는 듯한 이 기분 이 처참함 이 암담함 내가 호구따위보다")
    #    end
    #    test "@user 헐222222222222마자 왼쪽ㄱ....." do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 헐222222222222마자 왼쪽ㄱ.....")
    #    end
    #    test "(둘을 번갈아 바라보다 시무룩해진다" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("(둘을 번갈아 바라보다 시무룩해진다")
    #    end
    #    test "입문작이 더블이다보니 당연히 중간에 더블 디케이드 무비대전을보게되는데 그때 본 디케이드를 보고 ..?" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("입문작이 더블이다보니 당연히 중간에 더블 디케이드 무비대전을보게되는데 그때 본 디케이드를 보고 ..?")
    #    end
    #    test "@user  ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ 진짜 사진도 어쩜 저렇게 해맑은 사진을 썼냐곸ㅋㅋㅋㅋ 귀엽겤ㅋㅋㅋㅋ 이제 한명 남았네여^^ ~~ 펜타킬가자~~" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("@user  ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ 진짜 사진도 어쩜 저렇게 해맑은 사진을 썼냐곸ㅋㅋㅋㅋ 귀엽겤ㅋㅋㅋㅋ 이제 한명 남았네여^^ ~~ 펜타킬가자~~")
    #    end
    #    test "자동트윗이 가는경우가 많아. 당황하지말아줘~~^_^" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("자동트윗이 가는경우가 많아. 당황하지말아줘~~^_^")
    #    end
    #    test "어둠따위에게 지지 않는다," do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("어둠따위에게 지지 않는다,")
    #    end
    #    test "@user 응, 훈남 맞아요. 누나도 편하게 해주세요!" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 응, 훈남 맞아요. 누나도 편하게 해주세요!")
    #    end
    #    test "@user 4님 보고오셨군욬ㅋㅋㅋㅋ" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 4님 보고오셨군욬ㅋㅋㅋㅋ")
    #    end
    #    test "허지웅, ‘소중한 한 표’ 투표 인증샷..“노예근성 악순환에 빠질수도” / 브레이크뉴스  http://link.com" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("허지웅, ‘소중한 한 표’ 투표 인증샷..“노예근성 악순환에 빠질수도” / 브레이크뉴스  http://link.com")
    #    end
    #    test "목상태가 안 좋아서 병원에 왔는데 걱정할 만큼 안 좋은 상태는 아니란다. 이런 경우 진성구와 가성구 사이에 있는 수분이 너무 적거나 너무 많아서 그럴 수 있다고 함 http://link.com" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("목상태가 안 좋아서 병원에 왔는데 걱정할 만큼 안 좋은 상태는 아니란다. 이런 경우 진성구와 가성구 사이에 있는 수분이 너무 적거나 너무 많아서 그럴 수 있다고 함 http://link.com")
    #    end
    #    test "손자른거봐.. 오빠센스쟁이귀염둥이ㅠㅠ♥ #신우" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("손자른거봐.. 오빠센스쟁이귀염둥이ㅠㅠ♥ #신우")
    #    end
    #    test "@user 에에 나도 방향치지만 거기 깼는데 ^ ^" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 에에 나도 방향치지만 거기 깼는데 ^ ^")
    #    end
    #    test "@user @user 오세요 ㅎ" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user 오세요 ㅎ")
    #    end
    #    test "@user @user ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ")
    #    end
    #    test "*..풋. 결국 농구인가." do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("*..풋. 결국 농구인가.")
    #    end
    #    test "으음.. 오늘 라면먹으러 갈까.. 내일갈까.." do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("으음.. 오늘 라면먹으러 갈까.. 내일갈까..")
    #    end
    #    test ""@user: 그래요 셀카요“@user: @user 대혀니가 셀카 찍어줬으니까 오빠도 한장...ㅋㄷㅋㄷ #BAP_whereareyou” http://link.com"" do
    #    assert_value KoreanSentenceAnalyser.analyse_sentence(""@user: 그래요 셀카요“@user: @user 대혀니가 셀카 찍어줬으니까 오빠도 한장...ㅋㄷㅋㄷ #BAP_whereareyou” http://link.com"")
    #  end
    #  test "@user @user 우ㅜㅜ우????" do
    #    assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user 우ㅜㅜ우????")
    #  end
    #  test "@user 오..오토멘잼서요? 생각보다 단행본 많이 나와잇길래 멍가 차마 읽어보진못햇눈데..ㄷㄷ" do
    #    assert_value KoreanSentenceAnalyser.analyse_sentence("@user 오..오토멘잼서요? 생각보다 단행본 많이 나와잇길래 멍가 차마 읽어보진못햇눈데..ㄷㄷ")
    #  end
    #  test "@user 검지가 대체물까요... 이거 엄청중요한거같은데ㅠㅠㅠ 토가시이이이이잉" do
    #    assert_value KoreanSentenceAnalyser.analyse_sentence("@user 검지가 대체물까요... 이거 엄청중요한거같은데ㅠㅠㅠ 토가시이이이이잉")
    #  end
    #  test "@user 재량휴업일~" do
    #    assert_value KoreanSentenceAnalyser.analyse_sentence("@user 재량휴업일~")
    #  end
    #  test "@user @user 너님 이제 뜯어먹힘" do
    #    assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user 너님 이제 뜯어먹힘")
    #  end
    #  test "RT @user: @user @user 바퀴벌레 무시하지마 쓰레기야" do
    #    assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: @user @user 바퀴벌레 무시하지마 쓰레기야")
    #  end
    #  test "@user 그칰ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ 특히 카오루 읍읍할때" do
    #    assert_value KoreanSentenceAnalyser.analyse_sentence("@user 그칰ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ 특히 카오루 읍읍할때")
    #  end
    #  test "@user http://link.com Chicago - United States - America의 @user 동영상에 좋아요 표시를 했습니다." do
    #    assert_value KoreanSentenceAnalyser.analyse_sentence("@user http://link.com Chicago - United States - America의 @user 동영상에 좋아요 표시를 했습니다.")
    #  end
    #  test "@user #웹슈터쏴서_돌돌말아 #그대로창밖에집어던지는" do
    #    assert_value KoreanSentenceAnalyser.analyse_sentence("@user #웹슈터쏴서_돌돌말아 #그대로창밖에집어던지는")
    #  end
    #  test "@user ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ으앙ㅇ 내 3시간!!!(바둥ㅇ바둥" do
    #    assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ으앙ㅇ 내 3시간!!!(바둥ㅇ바둥")
    #  end
    #  test "갑자기 궁금해졌는데 님들은 신타로 영어로 적을때 shintaro 라고 적으세요 아니면 sintaro 라고 적으세요..? 전 앞쪽으로 쓰는데" do
    #    assert_value KoreanSentenceAnalyser.analyse_sentence("갑자기 궁금해졌는데 님들은 신타로 영어로 적을때 shintaro 라고 적으세요 아니면 sintaro 라고 적으세요..? 전 앞쪽으로 쓰는데")
    #  end
    #  test "@user 제보감사합니다:~)" do
    #    assert_value KoreanSentenceAnalyser.analyse_sentence("@user 제보감사합니다:~)")
    #  end
    #  test "산신님 여섯발로 달리는거 그릴거야 아무도 날 막을 수 없따" do
    #    assert_value KoreanSentenceAnalyser.analyse_sentence("산신님 여섯발로 달리는거 그릴거야 아무도 날 막을 수 없따")
    #  end
    #  test "@user (침착하게 블락 해본다 (계정이 마음에 안 든다를 선택" do
    #    assert_value KoreanSentenceAnalyser.analyse_sentence("@user (침착하게 블락 해본다 (계정이 마음에 안 든다를 선택")
    #  end
    #  test "@user 떡볶이 ㅎㅎ 오래간만에 듣는 표현이네요 ㅋㅋ" do
    #    assert_value KoreanSentenceAnalyser.analyse_sentence("@user 떡볶이 ㅎㅎ 오래간만에 듣는 표현이네요 ㅋㅋ")
    #  end
    #  test "@user 너무재밌었어요ㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠ오랜만에봤는데진짜.. 또만나요단공때도또 ㅠㅠㅠ 아이돌오빠.." do
    #    assert_value KoreanSentenceAnalyser.analyse_sentence("@user 너무재밌었어요ㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠ오랜만에봤는데진짜.. 또만나요단공때도또 ㅠㅠㅠ 아이돌오빠..")
    #  end
    #  test "한국쪽은 원하시는 지인분들에게만..ㅇ&gt;-&lt;.." do
    #    assert_value KoreanSentenceAnalyser.analyse_sentence("한국쪽은 원하시는 지인분들에게만..ㅇ&gt;-&lt;..")
    #  end
    #  test "RT @user: /////ㅎㅅㅎ////// #친해지고싶다_RT_반모하고싶다_멘션_이미_친한것같다_인용디스" do
    #    assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: /////ㅎㅅㅎ////// #친해지고싶다_RT_반모하고싶다_멘션_이미_친한것같다_인용디스")
    #  end
    #  test "@user 아니 좋은 아침이네요." do
    #    assert_value KoreanSentenceAnalyser.analyse_sentence("@user 아니 좋은 아침이네요.")
    #  end
    #  test "@user (도리도리) .... 우으...." do
    #    assert_value KoreanSentenceAnalyser.analyse_sentence("@user (도리도리) .... 우으....")
    #  end
    #  test "전방에 일제포격! #Xenon" do
    #    assert_value KoreanSentenceAnalyser.analyse_sentence("전방에 일제포격! #Xenon")
    #  end
    #  test "@user 대기하나주네요 아싸" do
    #    assert_value KoreanSentenceAnalyser.analyse_sentence("@user 대기하나주네요 아싸")
    #  end
    #  test "성규가 마지막이네~~~~~" do
    #    assert_value KoreanSentenceAnalyser.analyse_sentence("성규가 마지막이네~~~~~")
    #  end
    #  test "@user 아 뭐여 끝물이네...즁구어빠죽게따..." do
    #    assert_value KoreanSentenceAnalyser.analyse_sentence("@user 아 뭐여 끝물이네...즁구어빠죽게따...")
    #  end
    #  test "@user 그러게여...히히" do
    #    assert_value KoreanSentenceAnalyser.analyse_sentence("@user 그러게여...히히")
    #  end
    #  test "@user 나인가(땡" do
    #    assert_value KoreanSentenceAnalyser.analyse_sentence("@user 나인가(땡")
    #  end
    #  test "@user 그니까 언데드잖ㅇㅏㅏㅏㅏ~~!!!!" do
    #    assert_value KoreanSentenceAnalyser.analyse_sentence("@user 그니까 언데드잖ㅇㅏㅏㅏㅏ~~!!!!")
    #  end
    #  test "@user #꼼투표독려이벵 http://link.com 참여합니다!!" do
    #    assert_value KoreanSentenceAnalyser.analyse_sentence("@user #꼼투표독려이벵 http://link.com 참여합니다!!")
    #  end
    #  test "헐 내일 여덟시간짜리 스터디 취소돼서 엉엉 너무 좋아... 요가도 가고 병원도 가고 헤헤" do
    #    assert_value KoreanSentenceAnalyser.analyse_sentence("헐 내일 여덟시간짜리 스터디 취소돼서 엉엉 너무 좋아... 요가도 가고 병원도 가고 헤헤")
    #  end
    #  test "니코 키를..아,거기의 나,좋은 타이밍인데?풉." do
    #    assert_value KoreanSentenceAnalyser.analyse_sentence("니코 키를..아,거기의 나,좋은 타이밍인데?풉.")
    #  end
    #  test "@user 으아 부러워요ㅠㅁㅠ.." do
    #    assert_value KoreanSentenceAnalyser.analyse_sentence("@user 으아 부러워요ㅠㅁㅠ..")
    #  end
    #  test "조녜....사람이 아니었다 하더라."@user: 8◇8♬ 팬들에게 한걸음 더 가까이. 살포시 앉아있는 자세까지 귀여울일... 사랑둥이얌♥ #LUHAN #루한 http://link.com http://link.com"" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("조녜....사람이 아니었다 하더라."@user: 8◇8♬ 팬들에게 한걸음 더 가까이. 살포시 앉아있는 자세까지 귀여울일... 사랑둥이얌♥ #LUHAN #루한 http://link.com http://link.com"")
    # end
    # test "@user 저도 다시 한 번 명심하지요." do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 저도 다시 한 번 명심하지요.")
    # end
    # test "@user 비밀 ' 3`)" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 비밀 ' 3`)")
    # end
    # test "핀과 제이크의 기묘한 모험 http://link.com (#tvple)" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("핀과 제이크의 기묘한 모험 http://link.com (#tvple)")
    # end
    # test "RT @user: 사복남 군복녀 소개 좀" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 사복남 군복녀 소개 좀")
    # end
    # test "@user 아! 그래서 그랬구먼요 ㅋㅋㅋㅋㅋㅋ" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 아! 그래서 그랬구먼요 ㅋㅋㅋㅋㅋㅋ")
    # end
    # test "@user 별글 보는거 귀찮으면 디엠 바로 하는건 어때?" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 별글 보는거 귀찮으면 디엠 바로 하는건 어때?")
    # end
    # test "@user 여름엔 맥주죠. 어여 달려가세요! ㅋㅋㅋㅌ" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 여름엔 맥주죠. 어여 달려가세요! ㅋㅋㅋㅌ")
    # end
    # test "@user 열ㄹ심히 머리를 굴랴보겠ㅅ습니다0ㅁ0!!!" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 열ㄹ심히 머리를 굴랴보겠ㅅ습니다0ㅁ0!!!")
    # end
    # test "@user 앗 네 가능합니다~~잘부탁드려요!" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 앗 네 가능합니다~~잘부탁드려요!")
    # end
    # test "이문세 갑상선암을 딛고 다시 일어서라. 라일락꽃 향기 맡으며." do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("이문세 갑상선암을 딛고 다시 일어서라. 라일락꽃 향기 맡으며.")
    # end
    # test "@user 큰일이야....다 2위야...ㅜㅠ" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 큰일이야....다 2위야...ㅜㅠ")
    # end
    # test "@user 어쩐지 위험한 냄새 풀풀 풍기는게 피터 같지 않은 느낌이었어요ㅋㅋㅋㅋ" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 어쩐지 위험한 냄새 풀풀 풍기는게 피터 같지 않은 느낌이었어요ㅋㅋㅋㅋ")
    # end
    # test "@user 아니요 ~~~~" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 아니요 ~~~~")
    # end
    # test "@user 크헹 재미없는거같아요..(코쓱 저만즐기는 썰" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 크헹 재미없는거같아요..(코쓱 저만즐기는 썰")
    # end
    # test "으리!!!! http://link.com" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("으리!!!! http://link.com")
    # end
    # test "금메달땄어~ 뽑보해죠~ http://link.com" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("금메달땄어~ 뽑보해죠~ http://link.com")
    # end
    # test "@user 으어억 삼님을 생각함서 그렸습니다~~!!진짜로~!!" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 으어억 삼님을 생각함서 그렸습니다~~!!진짜로~!!")
    # end
    # test "아…음… 잠깐 있다 얘기할까? 지금 좀 바쁘거든…" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("아…음… 잠깐 있다 얘기할까? 지금 좀 바쁘거든…")
    # end
    # test "5. 같이 하고 싶은 코스: 사이퍼즈 팀코!" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("5. 같이 하고 싶은 코스: 사이퍼즈 팀코!")
    # end
    # test "@user 하루에한거한번에보내도되용??" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 하루에한거한번에보내도되용??")
    # end
    # test "내 주변도 다 투표 했다던데..ㅠㅠ #투표합시다" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("내 주변도 다 투표 했다던데..ㅠㅠ #투표합시다")
    # end
    # test "이런 시국에 인천 경기를 놓치냐. 안절부절한 여당 앞에서 야당이 뭐 하는게 없다." do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("이런 시국에 인천 경기를 놓치냐. 안절부절한 여당 앞에서 야당이 뭐 하는게 없다.")
    # end
    # test "2덱 파체가없어서아쉽다 http://link.com" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("2덱 파체가없어서아쉽다 http://link.com")
    # end
    # test "이거 허니비 사진아니야..? 팬페가 팬페사진으로 2차가공잼ㅋㅋㅋㅋㅋㅋㅋㅋㅋ http://link.com" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("이거 허니비 사진아니야..? 팬페가 팬페사진으로 2차가공잼ㅋㅋㅋㅋㅋㅋㅋㅋㅋ http://link.com")
    # end
    # test "@user 그럴래여??" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 그럴래여??")
    # end
    # test "@user @user 같이 전력 120분해여..." do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user 같이 전력 120분해여...")
    # end
    # test "@user 그거같애 니코니코에서 바로오빠가쓴 복어모자" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 그거같애 니코니코에서 바로오빠가쓴 복어모자")
    # end
    # test "@user 헐....부러어워ㅜㅟㅜㅜㅜㅟㅜㅜㅜㅜㅜㅜㅜㅜㅜㅜㅜ나도풀밭주세요ㅜㅜㅜㅜㅜㅠㅣㅜㅜ" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 헐....부러어워ㅜㅟㅜㅜㅜㅟㅜㅜㅜㅜㅜㅜㅜㅜㅜㅜㅜ나도풀밭주세요ㅜㅜㅜㅜㅜㅠㅣㅜㅜ")
    # end
    # test "@user 엥? 나오타싫아행?" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 엥? 나오타싫아행?")
    # end
    # test "아니 일본ㅇ나이로 시팔이면 우리랑 동갑잼임" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("아니 일본ㅇ나이로 시팔이면 우리랑 동갑잼임")
    # end
    # test "@user ㅋㅋㅋㅋㅋ말해 얼른" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅋㅋㅋㅋㅋ말해 얼른")
    # end
    # test "#닮았다고들어본동물 이길수가없음.. 나 이거 짱많이닮음 http://link.com" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("#닮았다고들어본동물 이길수가없음.. 나 이거 짱많이닮음 http://link.com")
    # end
    # test "@user 야좀따가 마퍄할래?" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 야좀따가 마퍄할래?")
    # end
    # test "@user 다..담주욘" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 다..담주욘")
    # end
    # test "@user 아 핑구...♥나 얼마전에 친구들이랑 어릴때봤던 애니 말하다가 추억여행으로...슈가슈가룬 도레미 카드캡터채리 별의별거 다나오더라 ㅋㅋㅋ" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 아 핑구...♥나 얼마전에 친구들이랑 어릴때봤던 애니 말하다가 추억여행으로...슈가슈가룬 도레미 카드캡터채리 별의별거 다나오더라 ㅋㅋㅋ")
    # end
    # test "@user 너 참 슬퍼보여 친구 ." do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 너 참 슬퍼보여 친구 .")
    # end
    # test "1. 지선에서의 서울의 상징성" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("1. 지선에서의 서울의 상징성")
    # end
    # test "RT @user: 으악 이제 잘래요! #제국의아이들 타이틀은 #숨소리" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 으악 이제 잘래요! #제국의아이들 타이틀은 #숨소리")
    # end
    # test "후... 쿠로코를 다시파야하나..." do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("후... 쿠로코를 다시파야하나...")
    # end
    # test "@user A ㅏ... 경기도민이시죠... ㅠㅜ" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user A ㅏ... 경기도민이시죠... ㅠㅜ")
    # end
    # test "@user 못 시킨것도 통판으로.... 아예 온리 주최...." do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 못 시킨것도 통판으로.... 아예 온리 주최....")
    # end
    # test "-행운의날짜: 9,12,22,27" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("-행운의날짜: 9,12,22,27")
    # end
    # test "* 반드시 해시태그 “#EMCFORUM” 을 유지해주세요!" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("* 반드시 해시태그 “#EMCFORUM” 을 유지해주세요!")
    # end
    # test "@user 사제지간의 연은 없으니 사형이란 표현은 어울리지 않는군요. 그냥 협이라고 호칭을 붙이시면 될 것 같습니다." do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 사제지간의 연은 없으니 사형이란 표현은 어울리지 않는군요. 그냥 협이라고 호칭을 붙이시면 될 것 같습니다.")
    # end
    # test "@user =w= 귀여우세요(쓰담쓰담)" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user =w= 귀여우세요(쓰담쓰담)")
    # end
    # test "가슴과 목에 새겨진 이것은 악신을 봉인한 마법의 주문... 라기보단 보기 멋지지 않은가. 나름 패션이라네." do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("가슴과 목에 새겨진 이것은 악신을 봉인한 마법의 주문... 라기보단 보기 멋지지 않은가. 나름 패션이라네.")
    # end
    # test "@user 사과같은내새꾸~이쁘기도하지요~너도이너래불렄ㅋㅋㅋㅋㅋ" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 사과같은내새꾸~이쁘기도하지요~너도이너래불렄ㅋㅋㅋㅋㅋ")
    # end
    # test "@user 앝 늦게 드시는구나..  ㅠㅜ 넵! 그럼 그동안 푸키님은 뭐하시나용??" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 앝 늦게 드시는구나..  ㅠㅜ 넵! 그럼 그동안 푸키님은 뭐하시나용??")
    # end
    # test "@user @user 예전에바우님 닉넴이 퓨어한바우님이엿던거 저는 다기억해요^♥^" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user 예전에바우님 닉넴이 퓨어한바우님이엿던거 저는 다기억해요^♥^")
    # end
    # test "[YERY BAND] 예리밴드 '로미오 마네킹' official MV: http://link.com @user aracılığıyla" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("[YERY BAND] 예리밴드 '로미오 마네킹' official MV: http://link.com @user aracılığıyla")
    # end
    # test "@user 인생 재밌음? 차라리 스포당하는게 낫겠다" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 인생 재밌음? 차라리 스포당하는게 낫겠다")
    # end
    # test "존나 합리화봐봐 지가 지금 저딴식으로 욕하는게 당연하다는건가 ㅋㅋㅋ 걍 관심끌란다 좃같아서진짜 ㅋㅋ" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("존나 합리화봐봐 지가 지금 저딴식으로 욕하는게 당연하다는건가 ㅋㅋㅋ 걍 관심끌란다 좃같아서진짜 ㅋㅋ")
    # end
    # test "RT @user: @user but now eyu is blonde right? i saw her last yearㅋㅋㅋ" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: @user but now eyu is blonde right? i saw her last yearㅋㅋㅋ")
    # end
    # test ""@user: @user 수원ㅗ" 얘좀봐 효의 도시 수원 욕함" do
    #                                          assert_value KoreanSentenceAnalyser.analyse_sentence(""@user: @user 수원ㅗ" 얘좀봐 효의 도시 수원 욕함")
    #                                          end
    # test "@user 같이할랰ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 같이할랰ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ")
    # end
    # test "@user 규칙적인 생활이라는 게 말이 쉽지 지키긴 정말 어려운 거니까. 그 생활의 기본이 자는 시간 깨는 시간이잖아." do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 규칙적인 생활이라는 게 말이 쉽지 지키긴 정말 어려운 거니까. 그 생활의 기본이 자는 시간 깨는 시간이잖아.")
    # end
    # test "@user 컴파일 에러가 계속 나면 컴퓨터를 껏다 켜면 되는경우는 있죠." do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 컴파일 에러가 계속 나면 컴퓨터를 껏다 켜면 되는경우는 있죠.")
    # end
    # test "@user @user ㅜㅜㅜㅜ" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user ㅜㅜㅜㅜ")
    # end
    # test "@user 사보가 안그럴거라고 믿으니까 그랬지ㅋㅋㅋ뭐 사보라면 별로 상관없지만....." do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 사보가 안그럴거라고 믿으니까 그랬지ㅋㅋㅋ뭐 사보라면 별로 상관없지만.....")
    # end
    # test "정지화면 아님 https://t.co/pfyTKiaSki" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("정지화면 아님 https://t.co/pfyTKiaSki")
    # end
    # test "@user 미와ㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠ" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 미와ㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠ")
    # end
    # test "⠀⠀⠀⠀ㅤ ✿ ، #صء آلٓخير '" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("⠀⠀⠀⠀ㅤ ✿ ، #صء آلٓخير '")
    # end
    # test "걍 교통카드에 내일 쓸 만원 남겨두고 다 넣어야지" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("걍 교통카드에 내일 쓸 만원 남겨두고 다 넣어야지")
    # end
    # test ""@user: @user 400명되면 언팔해서 399명 되게 해야지"" do
    #                                              assert_value KoreanSentenceAnalyser.analyse_sentence(""@user: @user 400명되면 언팔해서 399명 되게 해야지"")
    #                                              end
    # test "@user 이토준지만화 재밌죠ㅋㅋ 호러인데 공상비슷하고 창의적인게많아서 더재밌는것같아요.. 유명한 소용돌이나 토미에 아니면" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 이토준지만화 재밌죠ㅋㅋ 호러인데 공상비슷하고 창의적인게많아서 더재밌는것같아요.. 유명한 소용돌이나 토미에 아니면")
    # end
    # test "스킬트리도 네이버 블로그마다 다 제각각이야" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("스킬트리도 네이버 블로그마다 다 제각각이야")
    # end
    # test "@user 시즈카도요. 으음, 이런곳에서 말하긴 뭐하지만 내일을 위해서라도 푹 주무세요." do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 시즈카도요. 으음, 이런곳에서 말하긴 뭐하지만 내일을 위해서라도 푹 주무세요.")
    # end
    # test "@user 전그건 중장년층이라구 생각하는 ㅋㄱㄲ 청년층은 무용감보다는 무관심쪽인거같아요 ㅋㅋㅋ" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 전그건 중장년층이라구 생각하는 ㅋㄱㄲ 청년층은 무용감보다는 무관심쪽인거같아요 ㅋㅋㅋ")
    # end
    # test "@user 아냐 안이뻐~" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 아냐 안이뻐~")
    # end
    # test "@user 으앙ㅋㅋㅋㅋㅋㅋ 저도 어떤사람이 따뜻한 아이스초코 주세요하는거 본적잇는데 ㅋㅋㅋ" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 으앙ㅋㅋㅋㅋㅋㅋ 저도 어떤사람이 따뜻한 아이스초코 주세요하는거 본적잇는데 ㅋㅋㅋ")
    # end
    # test "역시 개표방송은 스브스가 지존이야ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("역시 개표방송은 스브스가 지존이야ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ")
    # end
    # test "RT @user 분당 추천 웨딩홀 코리아디자인센터 컨벤션웨딩홀, 넓고 세련된 시설을 블로그 리뷰로 만나보세요 http://link.com      이글 알티한 5분께 스타벅스라떼를 드려요" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user 분당 추천 웨딩홀 코리아디자인센터 컨벤션웨딩홀, 넓고 세련된 시설을 블로그 리뷰로 만나보세요 http://link.com      이글 알티한 5분께 스타벅스라떼를 드려요")
    # end
    # test "RT @user: 140603 #풀하우스 막공 울음 참으려고 하는 운이 8_8 #빅스 #기적 #VIXX #ETERNITY #LEO #택운  http://link.com 니가 내 별이다 정택운!!!! @user http://link.com…" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 140603 #풀하우스 막공 울음 참으려고 하는 운이 8_8 #빅스 #기적 #VIXX #ETERNITY #LEO #택운  http://link.com 니가 내 별이다 정택운!!!! @user http://link.com…")
    # end
    # test "@user 라임색 조각 두개랑 마젠타색 조각 끼워볼게!!" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 라임색 조각 두개랑 마젠타색 조각 끼워볼게!!")
    # end
    # test "지방인이라도 마음만 먹으면 혼자서라도 갈 수 있는데 이번 연휴 내내 할 게 너무 많아서 너무 바쁘다 작곡숙제도 많고 학교숙제도 많고 공부도 해야하고 책도 읽어야 하고" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("지방인이라도 마음만 먹으면 혼자서라도 갈 수 있는데 이번 연휴 내내 할 게 너무 많아서 너무 바쁘다 작곡숙제도 많고 학교숙제도 많고 공부도 해야하고 책도 읽어야 하고")
    # end
    # test "@user @user 엩ㅌ맞다" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user 엩ㅌ맞다")
    # end
    # test "@user ㅎㅎㅎ모닝덕질은 좋은거니까요^^" do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅎㅎㅎ모닝덕질은 좋은거니까요^^")
    # end
    # test "에그냥 조금 웃긴다던가 소름돋는다던ㄴ가 귀여운ㄴ짤..." do
    #  assert_value KoreanSentenceAnalyser.analyse_sentence("에그냥 조금 웃긴다던가 소름돋는다던ㄴ가 귀여운ㄴ짤...")
    # end
    # test "RT @user: 이런좌빨놈 노동당사무국장 이런놈보기싫어서 일어나투표하러간다  시민들이여 일어나투표소로가자  어서들~~~~??? http://link.com"" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 이런좌빨놈 노동당사무국장 이런놈보기싫어서 일어나투표하러간다  시민들이여 일어나투표소로가자  어서들~~~~??? http://link.com"")
    # end
    # test "@user 헐쩔어개부러워..." do
    #                        assert_value KoreanSentenceAnalyser.analyse_sentence("@user 헐쩔어개부러워...")
    #                        end
    # test "@user 못있&gt;못잊...제가 지금 졸립니다...(넘)" do
    #                                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user 못있&gt;못잊...제가 지금 졸립니다...(넘)")
    #                                         end
    # test "이명박 전 대통령 투표소 신분증 대신 신용카드 내밀어 '웃음바다' http://link.com 보고있나 개콘?" do
    #                                                                     assert_value KoreanSentenceAnalyser.analyse_sentence("이명박 전 대통령 투표소 신분증 대신 신용카드 내밀어 '웃음바다' http://link.com 보고있나 개콘?")
    #                                                                     end
    # test "@user 흐히히♡" do
    #                  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 흐히히♡")
    #                  end
    # test "@user 롵님이 가라하면 바로 가야져 요망한 토끼!!!!!" do
    #                                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user 롵님이 가라하면 바로 가야져 요망한 토끼!!!!!")
    #                                         end
    # test "기광이랑 동운오빠 트윗주고받는거 너무 기엽따.....♥" do
    #                                      assert_value KoreanSentenceAnalyser.analyse_sentence("기광이랑 동운오빠 트윗주고받는거 너무 기엽따.....♥")
    #                                      end
    # test "@user ㅋㅋㅋㅋㅋ마음은이미양님옆에....ㅎㅎ...ㅋㅋㅋㅋ" do
    #                                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅋㅋㅋㅋㅋ마음은이미양님옆에....ㅎㅎ...ㅋㅋㅋㅋ")
    #                                         end
    # test "@user 아하(灬 ´ิω´ิ灬)! 잠시 생각을 못했어요ㅋ 그럼 지금 자전거 경기부에서 자전거 타실 예정이예요?(●ﾟ ∇ﾟ)ﾉ" do
    #                                                                              assert_value KoreanSentenceAnalyser.analyse_sentence("@user 아하(灬 ´ิω´ิ灬)! 잠시 생각을 못했어요ㅋ 그럼 지금 자전거 경기부에서 자전거 타실 예정이예요?(●ﾟ ∇ﾟ)ﾉ")
    #                                                                              end
    # test "고딩히뱌11!! http://link.com" do
    #                                assert_value KoreanSentenceAnalyser.analyse_sentence("고딩히뱌11!! http://link.com")
    #                                end
    # test "@user 과거엔 대충 전과 있으면 학생시절에 운동권이라 그런건데 법이 바뀌면서 전과 표시 허들이 낮아져서 각종 전과가 보이는 그런..." do
    #                                                                                    assert_value KoreanSentenceAnalyser.analyse_sentence("@user 과거엔 대충 전과 있으면 학생시절에 운동권이라 그런건데 법이 바뀌면서 전과 표시 허들이 낮아져서 각종 전과가 보이는 그런...")
    #                                                                                    end
    # test "@user 응응!스트레스 받지말고 얼른얼른 풀수 있었으면 좋겠다!😘💕" do
    #                                                assert_value KoreanSentenceAnalyser.analyse_sentence("@user 응응!스트레스 받지말고 얼른얼른 풀수 있었으면 좋겠다!😘💕")
    #                                                end
    # test "@user 눈을감으면 가이드곡을 성규가 했어요????" do
    #                                     assert_value KoreanSentenceAnalyser.analyse_sentence("@user 눈을감으면 가이드곡을 성규가 했어요????")
    #                                     end
    # test "@user 한국도 근데 대통령 보니 자랑할나라는 아니고 ㅎㅎ" do
    #                                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user 한국도 근데 대통령 보니 자랑할나라는 아니고 ㅎㅎ")
    #                                         end
    # test "RT @user: 原「하나미야, 나눗셈에서 나머지가 뭐야?」" do
    #                                         assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 原「하나미야, 나눗셈에서 나머지가 뭐야?」")
    #                                         end
    # test "13~14년도 한화가 이겼을 때 http://link.com" do
    #                                         assert_value KoreanSentenceAnalyser.analyse_sentence("13~14년도 한화가 이겼을 때 http://link.com")
    #                                         end
    # test "선거는 했지만 이번엔 딱히 인증샷을 찍지 않아서 [ . _.]" do
    #                                          assert_value KoreanSentenceAnalyser.analyse_sentence("선거는 했지만 이번엔 딱히 인증샷을 찍지 않아서 [ . _.]")
    #                                          end
    # test "@user 배구유니폼 반바지 지존" do
    #                          assert_value KoreanSentenceAnalyser.analyse_sentence("@user 배구유니폼 반바지 지존")
    #                          end
    # test "@user 엩ㄸ.. 꿇어도 안해줄거다 닝겐! ( •̀ω&lt;)" do
    #                                           assert_value KoreanSentenceAnalyser.analyse_sentence("@user 엩ㄸ.. 꿇어도 안해줄거다 닝겐! ( •̀ω&lt;)")
    #                                           end
    # test "Facebook에 새 사진을 게시했습니다 http://link.com" do
    #                                              assert_value KoreanSentenceAnalyser.analyse_sentence("Facebook에 새 사진을 게시했습니다 http://link.com")
    #                                              end
    # test "여자? 남자? http://link.com" do
    #                               assert_value KoreanSentenceAnalyser.analyse_sentence("여자? 남자? http://link.com")
    #                               end
    # test "@user 빨간지붕과 파란지붕은 거울문을 하나로 둔채 이어져있는 건물입니다." do
    #                                                  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 빨간지붕과 파란지붕은 거울문을 하나로 둔채 이어져있는 건물입니다.")
    #                                                  end
    # test "ㅠㅠ,,ㅠ,ㅠ 쉬바 꼭언니 선풍이,,모두에게 보여주고싶ㅍ어,,,하지만,,언닌 플텍이지,," do
    #                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("ㅠㅠ,,ㅠ,ㅠ 쉬바 꼭언니 선풍이,,모두에게 보여주고싶ㅍ어,,,하지만,,언닌 플텍이지,,")
    #                                                         end
    # test "3룸을 돌리면 두번만에 리니가 나오고 문득 돌리니까 3%의 r2니타가 나오고......" do
    #                                                        assert_value KoreanSentenceAnalyser.analyse_sentence("3룸을 돌리면 두번만에 리니가 나오고 문득 돌리니까 3%의 r2니타가 나오고......")
    #                                                        end
    # test "엄...엔솔인가...?.... 결론은 라이코니 사지못한다는건데요. 왜나는 일본이아닐까.. 아니 라이코니존잘님들이.왜 일본인이신걸까 ㅜㅠㅜㅜ" do
    #                                                                                     assert_value KoreanSentenceAnalyser.analyse_sentence("엄...엔솔인가...?.... 결론은 라이코니 사지못한다는건데요. 왜나는 일본이아닐까.. 아니 라이코니존잘님들이.왜 일본인이신걸까 ㅜㅠㅜㅜ")
    #                                                                                     end
    # test "@user (보다듬어쥼...사랑으로!" do
    #                            assert_value KoreanSentenceAnalyser.analyse_sentence("@user (보다듬어쥼...사랑으로!")
    #                            end
    # test "@user 탐라에 딱 어냐 페북에서만 보이는 언냐!!!!!" do
    #                                        assert_value KoreanSentenceAnalyser.analyse_sentence("@user 탐라에 딱 어냐 페북에서만 보이는 언냐!!!!!")
    #                                        end
    # test "아 나는 드친소 저거를.. 관글해주신 분을 선팔해아 할지 말아야 할지 모르겟" do
    #                                                  assert_value KoreanSentenceAnalyser.analyse_sentence("아 나는 드친소 저거를.. 관글해주신 분을 선팔해아 할지 말아야 할지 모르겟")
    #                                                  end
    # test "박빙지역 최종 투표차 예언.. 2%내외..." do
    #                                assert_value KoreanSentenceAnalyser.analyse_sentence("박빙지역 최종 투표차 예언.. 2%내외...")
    #                                end
    # test "@user 나도 ^-^( 닥터: 너말고쌍년아" do
    #                                assert_value KoreanSentenceAnalyser.analyse_sentence("@user 나도 ^-^( 닥터: 너말고쌍년아")
    #                                end
    # test "RT @user: 140604 JI YEON(지연) Random Play Dance (랜덤플레이 댄스): http://link.com" do
    #                                                                                  assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 140604 JI YEON(지연) Random Play Dance (랜덤플레이 댄스): http://link.com")
    #                                                                                  end
    # test "@user 미찐ㅌㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ미유미유ㄹ ㅏ고 부를거라매!" do
    #                                           assert_value KoreanSentenceAnalyser.analyse_sentence("@user 미찐ㅌㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ미유미유ㄹ ㅏ고 부를거라매!")
    #                                           end
    # test "@user ...저거는 무리입니다 아가씨." do
    #                               assert_value KoreanSentenceAnalyser.analyse_sentence("@user ...저거는 무리입니다 아가씨.")
    #                               end
    # test "@user 오 구럼 담 선거때는 휘님 같으신분을 위해 이벤트를 하게써요 ㅎ.ㅎ 히히" do
    #                                                      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 오 구럼 담 선거때는 휘님 같으신분을 위해 이벤트를 하게써요 ㅎ.ㅎ 히히")
    #                                                      end
    # test "@user @user 트위터 플텍계라도...." do
    #                                 assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user 트위터 플텍계라도....")
    #                                 end
    # test "RT @user: RT @user  국정원 내부고발자 징역2년6개월 구형? 노르웨이는 CIA내부고발자인 스노든을2년 연속 노벨평화상후보에 추천 http://link.com" do
    #                                                                                                       assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: RT @user  국정원 내부고발자 징역2년6개월 구형? 노르웨이는 CIA내부고발자인 스노든을2년 연속 노벨평화상후보에 추천 http://link.com")
    #                                                                                                       end
    # test "@user 문제가 없으면 생각할 게 없지." do
    #                               assert_value KoreanSentenceAnalyser.analyse_sentence("@user 문제가 없으면 생각할 게 없지.")
    #                               end
    # test "@user ㅋㅋㅋㅋㅋㅋ미꾸라지상....사요나라...." do
    #                                     assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅋㅋㅋㅋㅋㅋ미꾸라지상....사요나라....")
    #                                     end
    # test "@user 그건 라퓨타....." do
    #                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user 그건 라퓨타.....")
    #                         end
    # test "잠이 오지 않는 깊은 밤이면 내겐 불안감과 우울함이 밀려오지만, 네게만은 달콤한 꿈을 선사해주길. 씽아, 너의 날들을 언제나 응원해. Daughter - "Youth" (Live @ Air Studios) http://link.com" do
    #                                                                                                                                          assert_value KoreanSentenceAnalyser.analyse_sentence("잠이 오지 않는 깊은 밤이면 내겐 불안감과 우울함이 밀려오지만, 네게만은 달콤한 꿈을 선사해주길. 씽아, 너의 날들을 언제나 응원해. Daughter - "Youth" (Live @ Air Studios) http://link.com")
    #                                                                                                                                          end
    # test "@user 어찌됐든 아치팬분들이 충격먹은건 사실이죠.. 언라 파는 시점에서 누구에게 이용당하고 신체개조당하고 끔찍하게 죽은 애들이 있는건 감수해야하지않나싶어서." do
    #                                                                                                 assert_value KoreanSentenceAnalyser.analyse_sentence("@user 어찌됐든 아치팬분들이 충격먹은건 사실이죠.. 언라 파는 시점에서 누구에게 이용당하고 신체개조당하고 끔찍하게 죽은 애들이 있는건 감수해야하지않나싶어서.")
    #                                                                                                 end
    # test "@user ㅋㅋㅋㅋㅋㅋㅋ틈님두 시나리오병 저한테 옮으셔써!! 서류철로 사람 패줄거같다니 틈님 잔인한사람....(????" do
    #                                                                          assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅋㅋㅋㅋㅋㅋㅋ틈님두 시나리오병 저한테 옮으셔써!! 서류철로 사람 패줄거같다니 틈님 잔인한사람....(????")
    #                                                                          end
    # test "@user 이 트윗을 메렌이 싫어합니다....ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ짱짱 쎈 영정베른ㅋㅋㅋㄱㅋㅋㅋㅋㅋㅋ" do
    #                                                              assert_value KoreanSentenceAnalyser.analyse_sentence("@user 이 트윗을 메렌이 싫어합니다....ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ짱짱 쎈 영정베른ㅋㅋㅋㄱㅋㅋㅋㅋㅋㅋ")
    #                                                              end
    # test "[3편] ‘인력’ 데이터 사이언티스트(Data Scientist) 확보 【http://link.com】 ★네이버 블로그★" do
    #                                                                           assert_value KoreanSentenceAnalyser.analyse_sentence("[3편] ‘인력’ 데이터 사이언티스트(Data Scientist) 확보 【http://link.com】 ★네이버 블로그★")
    #                                                                           end
    # test "@user 잌ㅋㅋㅋㅋㅋㅋㅋㅋㅋ기욥" do
    #                          assert_value KoreanSentenceAnalyser.analyse_sentence("@user 잌ㅋㅋㅋㅋㅋㅋㅋㅋㅋ기욥")
    #                          end
    # test "@user 청불이라 못보시겟지만.... 암튼 푹푹 찌르고 좀 잔인하기두 햇어영ㅋㅋㅋㅋㅋ근데 진짜 그 어린시절만 따로 빼서 영화 나오면 진짜 개짱일것같아여ㅠㅠㅠㅠㅠㅠㅠㅠㅠ" do
    #                                                                                                      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 청불이라 못보시겟지만.... 암튼 푹푹 찌르고 좀 잔인하기두 햇어영ㅋㅋㅋㅋㅋ근데 진짜 그 어린시절만 따로 빼서 영화 나오면 진짜 개짱일것같아여ㅠㅠㅠㅠㅠㅠㅠㅠㅠ")
    #                                                                                                      end
    # test "@user 헐... 이게머람......" do
    #                             assert_value KoreanSentenceAnalyser.analyse_sentence("@user 헐... 이게머람......")
    #                             end
    # test "@user 해외배구분석 하키사이트분석 해외분석배구 해외분석축구" do
    #                                          assert_value KoreanSentenceAnalyser.analyse_sentence("@user 해외배구분석 하키사이트분석 해외분석배구 해외분석축구")
    #                                          end
    # test "@user 이거 그 오늘 촬영하는거 일반인이 찍은거 !" do
    #                                      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 이거 그 오늘 촬영하는거 일반인이 찍은거 !")
    #                                      end
    # test "RT @user: 빵니발이면 진저브레드맨 먹어야되는데........" do
    #                                             assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 빵니발이면 진저브레드맨 먹어야되는데........")
    #                                             end
    # test "@user 그러면 전 잠시 나가있을게요 후후후후후" do
    #                                   assert_value KoreanSentenceAnalyser.analyse_sentence("@user 그러면 전 잠시 나가있을게요 후후후후후")
    #                                   end
    # test "아 근데 제발 당 이름좀 막 바꾸지 마라 어차피 당색이나 생각은 존나 똑같으면서 사람 헷갈리게스리" do
    #                                                              assert_value KoreanSentenceAnalyser.analyse_sentence("아 근데 제발 당 이름좀 막 바꾸지 마라 어차피 당색이나 생각은 존나 똑같으면서 사람 헷갈리게스리")
    #                                                              end
    # test "@user 땡! ㅋㅋㅋ 알아서 맞춰보시오 ㅎㅎ" do
    #                                 assert_value KoreanSentenceAnalyser.analyse_sentence("@user 땡! ㅋㅋㅋ 알아서 맞춰보시오 ㅎㅎ")
    #                                 end
    # test "드네는다좋은데...멀미남...  뷰가너무좁아ㅜㅜㅜ 이미터만멀게해줘도ㅜㅜㅜㅜㅜ" do
    #                                                  assert_value KoreanSentenceAnalyser.analyse_sentence("드네는다좋은데...멀미남...  뷰가너무좁아ㅜㅜㅜ 이미터만멀게해줘도ㅜㅜㅜㅜㅜ")
    #                                                  end
    # test "RT @user: @user 생각해 보니 나도 고등학교 때 주변 사람이 다 하찮게 보였던 것도 같고.....항상 혼자 앉아서 일본 노래 들으면서 중얼거렸던 것 같기도 하고....아아아 안돼, 기억해내면 안 돼.....!" do
    #                                                                                                                                  assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: @user 생각해 보니 나도 고등학교 때 주변 사람이 다 하찮게 보였던 것도 같고.....항상 혼자 앉아서 일본 노래 들으면서 중얼거렸던 것 같기도 하고....아아아 안돼, 기억해내면 안 돼.....!")
    #                                                                                                                                  end
    # test "@user 아 그래야죠" do
    #                    assert_value KoreanSentenceAnalyser.analyse_sentence("@user 아 그래야죠")
    #                    end
    # test "2.떠오르는 동물:  중성화 고양이" do
    #                           assert_value KoreanSentenceAnalyser.analyse_sentence("2.떠오르는 동물:  중성화 고양이")
    #                           end
    # test "17. 겨울별자리의 왕자 오리온자리는 천구의 적도부근에 있으며 달의 몇 백배에 해당하는 영역을 차지하는 커다란 성좌로 지구의 대부분의 지역에서 관측 가능합니다. 덧붙여 남반구에서는 뒤집혀서 보입니다." do
    #                                                                                                                       assert_value KoreanSentenceAnalyser.analyse_sentence("17. 겨울별자리의 왕자 오리온자리는 천구의 적도부근에 있으며 달의 몇 백배에 해당하는 영역을 차지하는 커다란 성좌로 지구의 대부분의 지역에서 관측 가능합니다. 덧붙여 남반구에서는 뒤집혀서 보입니다.")
    #                                                                                                                       end
    # test "RT @user: [D-75]@user 코나빈스 가고싶어요ㅠㅠ 하와이 커피 먹고싶어요ㅠㅠ http://link.com" do
    #                                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: [D-75]@user 코나빈스 가고싶어요ㅠㅠ 하와이 커피 먹고싶어요ㅠㅠ http://link.com")
    #                                                                         end
    # test "11시30분에 반장떡볶이 먹고 사당 가야겠다." do
    #                                 assert_value KoreanSentenceAnalyser.analyse_sentence("11시30분에 반장떡볶이 먹고 사당 가야겠다.")
    #                                 end
    # test "아씨 며칠전부터 디엠씨 생각밖에 없네;;;" do
    #                               assert_value KoreanSentenceAnalyser.analyse_sentence("아씨 며칠전부터 디엠씨 생각밖에 없네;;;")
    #                               end
    # test "테쿠리님 망고님 뀨님..저와 친해지고 싶으시면........어서 빨리 신카이를 들고오시죠..(연성깡패)" do
    #                                                                 assert_value KoreanSentenceAnalyser.analyse_sentence("테쿠리님 망고님 뀨님..저와 친해지고 싶으시면........어서 빨리 신카이를 들고오시죠..(연성깡패)")
    #                                                                 end
    # test "@user 기대한다는 사람이 왠지모르게 엄청 아프게한다던가..." do
    #                                           assert_value KoreanSentenceAnalyser.analyse_sentence("@user 기대한다는 사람이 왠지모르게 엄청 아프게한다던가...")
    #                                           end
    # test "@user @user 나 다 기억하는데 그 겨울... 먼모자더라 그 방울모자!!!" do
    #                                                     assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user 나 다 기억하는데 그 겨울... 먼모자더라 그 방울모자!!!")
    #                                                     end
    # test "미어캣의 하루 http://link.com #유머 #재미 #웃긴 #ㅋㅋ http://link.com" do
    #                                                               assert_value KoreanSentenceAnalyser.analyse_sentence("미어캣의 하루 http://link.com #유머 #재미 #웃긴 #ㅋㅋ http://link.com")
    #                                                               end
    # test "@user 좋은아침이요:) 음.. 기절잠해서 잘 모르겠어요...." do
    #                                            assert_value KoreanSentenceAnalyser.analyse_sentence("@user 좋은아침이요:) 음.. 기절잠해서 잘 모르겠어요....")
    #                                            end
    # test "@user @user  이름 → 우현이원츄헤진" do
    #                                 assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user  이름 → 우현이원츄헤진")
    #                                 end
    # test "@user 똑똑하지?" do
    #                   assert_value KoreanSentenceAnalyser.analyse_sentence("@user 똑똑하지?")
    #                   end
    # test "@user ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ어윽ㅋㅋㅋㅋㅋㅋ좋긴한걸 셧다운제 폐지.... 휴... 저는 우리 지역이 0.3% 차이나서 팝콘잼하구있엌ㅋㅋㅋ" do
    #                                                                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ어윽ㅋㅋㅋㅋㅋㅋ좋긴한걸 셧다운제 폐지.... 휴... 저는 우리 지역이 0.3% 차이나서 팝콘잼하구있엌ㅋㅋㅋ")
    #                                                                                                         end
    # test "바꾼애야, 그 악수 세월호 가족에게 하면 않되겠니? RT @user: 박근혜가 서울 종로구 청... http://link.com" do
    #                                                                               assert_value KoreanSentenceAnalyser.analyse_sentence("바꾼애야, 그 악수 세월호 가족에게 하면 않되겠니? RT @user: 박근혜가 서울 종로구 청... http://link.com")
    #                                                                               end
    # test "3) 혹시 몰라서 패드를 쓰기 시작" do
    #                           assert_value KoreanSentenceAnalyser.analyse_sentence("3) 혹시 몰라서 패드를 쓰기 시작")
    #                           end
    # test "@user 역으로 나이가 많은데 생닭님보다 못그리는 사람이 있으니 삶에 의욕을 가지시길 바랍니다.(쭈글쭈글)" do
    #                                                                    assert_value KoreanSentenceAnalyser.analyse_sentence("@user 역으로 나이가 많은데 생닭님보다 못그리는 사람이 있으니 삶에 의욕을 가지시길 바랍니다.(쭈글쭈글)")
    #                                                                    end
    # test "@user 설빙이나 무난하게는 카페베네 빙수 갠찮음." do
    #                                     assert_value KoreanSentenceAnalyser.analyse_sentence("@user 설빙이나 무난하게는 카페베네 빙수 갠찮음.")
    #                                     end
    # test "@user ㅋㅋㅋㅋㅋㅋㅋㅋ" do
    #                      assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅋㅋㅋㅋㅋㅋㅋㅋ")
    #                      end
    # test "세시간48분째 이짓중이야..." do
    #                        assert_value KoreanSentenceAnalyser.analyse_sentence("세시간48분째 이짓중이야...")
    #                        end
    # test "@user 큐...  나도 셤이랑 프로젝트..   끝나면 덕질해야지;ㅅ;" do
    #                                                assert_value KoreanSentenceAnalyser.analyse_sentence("@user 큐...  나도 셤이랑 프로젝트..   끝나면 덕질해야지;ㅅ;")
    #                                                end
    # test "@user 봐도 모르겟져 여기는 바로 알 거리 생각하고 트윗일지도 ㅁ안 돌렸덛 걱 같은데... 킄 누구지....." do
    #                                                                       assert_value KoreanSentenceAnalyser.analyse_sentence("@user 봐도 모르겟져 여기는 바로 알 거리 생각하고 트윗일지도 ㅁ안 돌렸덛 걱 같은데... 킄 누구지.....")
    #                                                                       end
    # test "@user 넹 그래욤ㅇㅂㅇ//" do
    #                        assert_value KoreanSentenceAnalyser.analyse_sentence("@user 넹 그래욤ㅇㅂㅇ//")
    #                        end
    # test "@user 큐브보다 혜빈이가 이 새벽에 트위터를  하다니...세상에 이런일이!!!ㅋㅋㅋㅋㅋㅋㅋㅋㅋ공부하자 빈아 나능 이번주 주말부터 시작할테야ㅎㅎㅎ흑ㅠㅠㅠ" do
    #                                                                                              assert_value KoreanSentenceAnalyser.analyse_sentence("@user 큐브보다 혜빈이가 이 새벽에 트위터를  하다니...세상에 이런일이!!!ㅋㅋㅋㅋㅋㅋㅋㅋㅋ공부하자 빈아 나능 이번주 주말부터 시작할테야ㅎㅎㅎ흑ㅠㅠㅠ")
    #                                                                                              end
    # test "@user @user 내 스토커년ㅠㅠㅠ..." do
    #                                assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user 내 스토커년ㅠㅠㅠ...")
    #                                end
    # test "http://link.com" do
    #                       assert_value KoreanSentenceAnalyser.analyse_sentence("http://link.com")
    #                       end
    # test "@user 이제는 토시요리라고 하지않을게요 ㅎㅎ" do
    #                                  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 이제는 토시요리라고 하지않을게요 ㅎㅎ")
    #                                  end
    # test "@user 그래그래, 밍 팔랑귀 고놈 참 예뻐 보이네. 온도니 처럼 (^-^) #노리능" do
    #                                                        assert_value KoreanSentenceAnalyser.analyse_sentence("@user 그래그래, 밍 팔랑귀 고놈 참 예뻐 보이네. 온도니 처럼 (^-^) #노리능")
    #                                                        end
    # test "@user 그래. 그럼 시작할게? 끝까지 쫓아와." do
    #                                   assert_value KoreanSentenceAnalyser.analyse_sentence("@user 그래. 그럼 시작할게? 끝까지 쫓아와.")
    #                                   end
    # test "@user  ..윽.이게 뭐야.(불쾌한 표정을 지으며 그림을 이리저리 살펴 보다가 이내, 걸음을 옮겨 액자 5를 확인한다.)" do
    #                                                                             assert_value KoreanSentenceAnalyser.analyse_sentence("@user  ..윽.이게 뭐야.(불쾌한 표정을 지으며 그림을 이리저리 살펴 보다가 이내, 걸음을 옮겨 액자 5를 확인한다.)")
    #                                                                             end
    # test "RT @user: 대채로.. 에리들은. 트잉..." do
    #                                   assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 대채로.. 에리들은. 트잉...")
    #                                   end
    # test "@user 동이이이ㅣㅇ이!!!!!!!" do
    #                            assert_value KoreanSentenceAnalyser.analyse_sentence("@user 동이이이ㅣㅇ이!!!!!!!")
    #                            end
    # test ""@user: 140604 최파타 퇴근 성규 http://link.com"ㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠ울자ㅠㅠㅠㅠㅠㅠㅠ" do
    #                                                                                   assert_value KoreanSentenceAnalyser.analyse_sentence(""@user: 140604 최파타 퇴근 성규 http://link.com"ㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠ울자ㅠㅠㅠㅠㅠㅠㅠ")
    #                                                                                   end
    # test "@user ......? 그런가 ? 뭐, 그냥 대충대충하눈거라.." do
    #                                            assert_value KoreanSentenceAnalyser.analyse_sentence("@user ......? 그런가 ? 뭐, 그냥 대충대충하눈거라..")
    #                                            end
    # test "괜찮아 어차피 꿈도 희망도 없는 마계였어 허허허허 56% 찍은게 어디여 내가 선거도우미 할땐 50%였는데 어허허허허" do
    #                                                                        assert_value KoreanSentenceAnalyser.analyse_sentence("괜찮아 어차피 꿈도 희망도 없는 마계였어 허허허허 56% 찍은게 어디여 내가 선거도우미 할땐 50%였는데 어허허허허")
    #                                                                        end
    # test "..폰바꿨다고 와이파이가 암뒴.........(뒤엎" do
    #                                    assert_value KoreanSentenceAnalyser.analyse_sentence("..폰바꿨다고 와이파이가 암뒴.........(뒤엎")
    #                                    end
    # test "에헤이~! 남은 페이지 생각하면 그 인생이 고달퍼!" do
    #                                    assert_value KoreanSentenceAnalyser.analyse_sentence("에헤이~! 남은 페이지 생각하면 그 인생이 고달퍼!")
    #                                    end
    # test "@user 그래서 레고님 전체샷.... (쥴르ㅡㅡ륵..." do
    #                                       assert_value KoreanSentenceAnalyser.analyse_sentence("@user 그래서 레고님 전체샷.... (쥴르ㅡㅡ륵...")
    #                                       end
    # test "@user 괘... 괜찮슴다..." do
    #                          assert_value KoreanSentenceAnalyser.analyse_sentence("@user 괘... 괜찮슴다...")
    #                          end
    # test "류카, 1시래이. 밥 안먹노? 응, 별로. 잠결에 들려온 대화에 토키는 눈을 번쩍 떴다. 류카, 다이어트 하는기가? 토키의 질문에 당황한 류카가 아니라며 고개를 젓자, 토키는 "허벅지가 얇아지면 완벽한 베개가 아니래이" 라며 짐짓 엄한 표정을 지었다." do
    #                                                                                                                                                    assert_value KoreanSentenceAnalyser.analyse_sentence("류카, 1시래이. 밥 안먹노? 응, 별로. 잠결에 들려온 대화에 토키는 눈을 번쩍 떴다. 류카, 다이어트 하는기가? 토키의 질문에 당황한 류카가 아니라며 고개를 젓자, 토키는 "허벅지가 얇아지면 완벽한 베개가 아니래이" 라며 짐짓 엄한 표정을 지었다.")
    #                                                                                                                                                    end
    #                                                                                                                            test "@user @user 한번 보고는 싶은데.." do
    #                                                                                                                                                            assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user 한번 보고는 싶은데..")
    #                                                                                                                                                            end
    #                                                                                                                            test "@user 그래서 늦게 가게?" do
    #                                                                                                                                                    assert_value KoreanSentenceAnalyser.analyse_sentence("@user 그래서 늦게 가게?")
    #                                                                                                                                                    end
    #                                                                                                                            test "@user 네넨, 소원 하나 있어요. 설레게 해줄때마다 한개씩" do
    #                                                                                                                                                                      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 네넨, 소원 하나 있어요. 설레게 해줄때마다 한개씩")
    #                                                                                                                                                                      end
    #                                                                                                                            test "@user (손바닥으로 볼을 감싸주며 미소짓는다) 일주일 혹은 그보다 일찍, 마지막을 생각하면 불타오르는데ㅡ" do
    #                                                                                                                                                                                                assert_value KoreanSentenceAnalyser.analyse_sentence("@user (손바닥으로 볼을 감싸주며 미소짓는다) 일주일 혹은 그보다 일찍, 마지막을 생각하면 불타오르는데ㅡ")
    #                                                                                                                                                                                                end
    # test "@user 와 진기 역시 천사천사!" do
    #                           assert_value KoreanSentenceAnalyser.analyse_sentence("@user 와 진기 역시 천사천사!")
    #                           end
    # test "솔직히 스브스는 cg 볼려고 본다" do
    #                          assert_value KoreanSentenceAnalyser.analyse_sentence("솔직히 스브스는 cg 볼려고 본다")
    #                          end
    # test "@user 헐ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ아글이더웃기닼ㅋㅋㅋ" do
    #                                                       assert_value KoreanSentenceAnalyser.analyse_sentence("@user 헐ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ아글이더웃기닼ㅋㅋㅋ")
    #                                                       end
    # test "@user A:한번은 그런게 너무 싫어서 도착하자마자 샴페인을 집어들고 도망쳤다.다들 당황했고,난 따지도 않은걸 쓰레기통에 집어던졌다.그리고 다른사람들의 분노를 고스란히 받아야만했다." do
    #                                                                                                              assert_value KoreanSentenceAnalyser.analyse_sentence("@user A:한번은 그런게 너무 싫어서 도착하자마자 샴페인을 집어들고 도망쳤다.다들 당황했고,난 따지도 않은걸 쓰레기통에 집어던졌다.그리고 다른사람들의 분노를 고스란히 받아야만했다.")
    #                                                                                                              end
    # test "@user 지금 잠이 안와서 학교가서 잘것 같아요ㅠㅠㅜ" do
    #                                      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 지금 잠이 안와서 학교가서 잘것 같아요ㅠㅠㅜ")
    #                                      end
    # test "@user 예 하셨습니다 피곤합니다!" do
    #                            assert_value KoreanSentenceAnalyser.analyse_sentence("@user 예 하셨습니다 피곤합니다!")
    #                            end
    # test "저 뽀뽀가 엘성이들이엇으면 난 오늘 공부는 다햇엇겟지........ㅁㅊ!!!!!!!!생각하니까 개좋아!!!!!!!!!!" do
    #                                                                          assert_value KoreanSentenceAnalyser.analyse_sentence("저 뽀뽀가 엘성이들이엇으면 난 오늘 공부는 다햇엇겟지........ㅁㅊ!!!!!!!!생각하니까 개좋아!!!!!!!!!!")
    #                                                                          end
    # test "Facebook에 새 사진을 게시했습니다 http://link.com" do
    #                                              assert_value KoreanSentenceAnalyser.analyse_sentence("Facebook에 새 사진을 게시했습니다 http://link.com")
    #                                              end
    # test "@user 내가보기엔 둘다....." do
    #                           assert_value KoreanSentenceAnalyser.analyse_sentence("@user 내가보기엔 둘다.....")
    #                           end
    # test "@user 나두 ㅎㅎㅎ;;;;;;지금와서 팬인척 ㄴㄴ하실게요;;;;;;;;;;;;;;;;" do
    #                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user 나두 ㅎㅎㅎ;;;;;;지금와서 팬인척 ㄴㄴ하실게요;;;;;;;;;;;;;;;;")
    #                                                         end
    # test "@user 기쁘군요. 앞으로도 ~여름방학식까지 동결~ 톤씨와 친하게 지낼 수 있으면 좋겠네요." do
    #                                                            assert_value KoreanSentenceAnalyser.analyse_sentence("@user 기쁘군요. 앞으로도 ~여름방학식까지 동결~ 톤씨와 친하게 지낼 수 있으면 좋겠네요.")
    #                                                            end
    #                                                            test "oh @user noona, why u look like my uncle now... -_-" RT @user: 오늘도 함께라 즐거웠어요! 내일 또 만나요:) 별밤 가족들 굿밤♡ http://link.com" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("oh @user noona, why u look like my uncle now... -_-" RT @user: 오늘도 함께라 즐거웠어요! 내일 또 만나요:) 별밤 가족들 굿밤♡ http://link.com")
    #                                                                                                                                                                               end
    #                                                                                                                                                                               test "왜인지 태피스트리다크초콜릿캬라멜카푸치노를 소개하면 태피스트리를 이니스프리로 바꾸고 다크초콜릿은 밀크초콜릿이나 화이트 초콜릿으로 바꾸며 캬라멜은 꼭 맞추고 카푸치노가 카페라떼가 되는기적을 계속보게된다" do
    #                                                                                                                                                                                                                                                                                                     assert_value KoreanSentenceAnalyser.analyse_sentence("왜인지 태피스트리다크초콜릿캬라멜카푸치노를 소개하면 태피스트리를 이니스프리로 바꾸고 다크초콜릿은 밀크초콜릿이나 화이트 초콜릿으로 바꾸며 캬라멜은 꼭 맞추고 카푸치노가 카페라떼가 되는기적을 계속보게된다")
    #                                                                                                                                                                                                                                                                                                     end
    # test "@user  학기초에도 쟤뗌에 상처받음 ㅠ" do
    #                               assert_value KoreanSentenceAnalyser.analyse_sentence("@user  학기초에도 쟤뗌에 상처받음 ㅠ")
    #                               end
    # test "@user 서코보면 꽂는데 하나정도 있는데" do
    #                               assert_value KoreanSentenceAnalyser.analyse_sentence("@user 서코보면 꽂는데 하나정도 있는데")
    #                               end
    # test "@user 엑스맨 재밋대요!" do
    #                       assert_value KoreanSentenceAnalyser.analyse_sentence("@user 엑스맨 재밋대요!")
    #                       end
    # test "@user ... 그래도 소라잖아, 요.." do
    #                               assert_value KoreanSentenceAnalyser.analyse_sentence("@user ... 그래도 소라잖아, 요..")
    #                               end
    # test "@user 그럼 죽부인 모양이잔항(울적" do
    #                             assert_value KoreanSentenceAnalyser.analyse_sentence("@user 그럼 죽부인 모양이잔항(울적")
    #                             end
    # test "ارضني بـ آلوصل ،" do
    #                        assert_value KoreanSentenceAnalyser.analyse_sentence("ارضني بـ آلوصل ،")
    #                        end
    # test "@user @user 헥..." do
    #                        assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user 헥...")
    #                        end
    # test "@user 끝나고 바로 올린것도 씹덕ㅠㅠㅠㅠㅠ" do
    #                                 assert_value KoreanSentenceAnalyser.analyse_sentence("@user 끝나고 바로 올린것도 씹덕ㅠㅠㅠㅠㅠ")
    #                                 end
    # test "나 친구가 프린트 해달라는거 지금 돈없어서 해주기 싫은데 카톡을 씹어야 하나 말아야하나............." do
    #                                                                     assert_value KoreanSentenceAnalyser.analyse_sentence("나 친구가 프린트 해달라는거 지금 돈없어서 해주기 싫은데 카톡을 씹어야 하나 말아야하나.............")
    #                                                                     end
    # test "이빨이 초밥에 끼다 를 영어로 말하면?" do
    #                             assert_value KoreanSentenceAnalyser.analyse_sentence("이빨이 초밥에 끼다 를 영어로 말하면?")
    #                             end
    # test "@user @user 이럴 땐 소환을" do
    #                            assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user 이럴 땐 소환을")
    #                            end
    # test "@user 2자스mean 새누리당 최대 흑역사" do
    #                                 assert_value KoreanSentenceAnalyser.analyse_sentence("@user 2자스mean 새누리당 최대 흑역사")
    #                                 end
    # test "@user 백장찍어도 안나오는 저는 어쩌죠" do
    #                               assert_value KoreanSentenceAnalyser.analyse_sentence("@user 백장찍어도 안나오는 저는 어쩌죠")
    #                               end
    # test "@user 마무릿!! 근데 패미츠가 이거 맞나요...하튼 일케 찍어왔어요! http://link.com" do
    #                                                                 assert_value KoreanSentenceAnalyser.analyse_sentence("@user 마무릿!! 근데 패미츠가 이거 맞나요...하튼 일케 찍어왔어요! http://link.com")
    #                                                                 end
    # test "“@user: YC: "If there's chance, I want to record a song together with 5 ppl" ㅠㅠㅠㅠㅠㅠㅠㅠㅠ https://t.co/WemehrZSOZ” i just...." do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("“@user: YC: "If there's chance, I want to record a song together with 5 ppl" ㅠㅠㅠㅠㅠㅠㅠㅠㅠ https://t.co/WemehrZSOZ” i just....")
    #                                                                                                                             end
    #                                                                                                                             test "[63] 내일 지구가 멸망하더라도 나는 한 개의 트윗을 쓰겠다 - 트잉여" do
    #                                                                                                                                                                             assert_value KoreanSentenceAnalyser.analyse_sentence("[63] 내일 지구가 멸망하더라도 나는 한 개의 트윗을 쓰겠다 - 트잉여")
    #                                                                                                                                                                             end
    #                                                                                                                                  test "@user 아니요. 그럴리가 없습니다. (진지" do
    #                                                                                                                                                                   assert_value KoreanSentenceAnalyser.analyse_sentence("@user 아니요. 그럴리가 없습니다. (진지")
    #                                                                                                                                                                   end
    #                                                                                                                                  test "@user 부우우ㅡ. 아닌데, 하고 미사카는 미사카는 부정해본다." do
    #                                                                                                                                                                              assert_value KoreanSentenceAnalyser.analyse_sentence("@user 부우우ㅡ. 아닌데, 하고 미사카는 미사카는 부정해본다.")
    #                                                                                                                                                                              end
    #                                                                                                                                  test "@user @user 그치언니도 ㅂㅋ오빠라고 ㅁ못하겠지" do
    #                                                                                                                                                                        assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user 그치언니도 ㅂㅋ오빠라고 ㅁ못하겠지")
    #                                                                                                                                                                        end
    #                                                                                                                                  test "ما كلف الله نفس(ن) الى وسعها .. :) ㅤ" do
    #                                                                                                                                                                              assert_value KoreanSentenceAnalyser.analyse_sentence("ما كلف الله نفس(ن) الى وسعها .. :) ㅤ")
    #                                                                                                                                                                              end
    # test "RT @user: 1일 1토이 http://link.com" do
    #                                        assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 1일 1토이 http://link.com")
    #                                        end
    # test "@user 그랬구나! 모처럼 쉬는날인데 아쉽당´ㅅ`" do
    #                                    assert_value KoreanSentenceAnalyser.analyse_sentence("@user 그랬구나! 모처럼 쉬는날인데 아쉽당´ㅅ`")
    #                                    end
    # test "치료받고 집에 가고 있는데 스텔라가 밀탑이라는 말을 듣고 내 안의 빙수욕이 끓어올라 아쉬운대로 편의점빙수라도 먹겠다고 되돌아가고있다. 나의 식탐이여.." do
    #                                                                                            assert_value KoreanSentenceAnalyser.analyse_sentence("치료받고 집에 가고 있는데 스텔라가 밀탑이라는 말을 듣고 내 안의 빙수욕이 끓어올라 아쉬운대로 편의점빙수라도 먹겠다고 되돌아가고있다. 나의 식탐이여..")
    #                                                                                            end
    # test "@user 오빠 진짜 뭔가 옆집오빠처럼 친근하다...♥ 나는 내년부터~" do
    #                                               assert_value KoreanSentenceAnalyser.analyse_sentence("@user 오빠 진짜 뭔가 옆집오빠처럼 친근하다...♥ 나는 내년부터~")
    #                                               end
    # test "@user 섹드립 펑펑펑" do
    #                     assert_value KoreanSentenceAnalyser.analyse_sentence("@user 섹드립 펑펑펑")
    #                     end
    # test "RT @user: 140604 #지드래곤 샤넬 패션쇼 NEW 사진 + 영상 ♡" do
    #                                                   assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 140604 #지드래곤 샤넬 패션쇼 NEW 사진 + 영상 ♡")
    #                                                   end
    # test "4.지금인상☞ 짱천사여...ㅜㅠㅜㅜ" do
    #                           assert_value KoreanSentenceAnalyser.analyse_sentence("4.지금인상☞ 짱천사여...ㅜㅠㅜㅜ")
    #                           end
    # test "@user 올라가 봅니다." do
    #                      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 올라가 봅니다.")
    #                      end
    # test "@user 오글오긄거려섴ㅋㅋㅋㅋㅋㅋ" do
    #                           assert_value KoreanSentenceAnalyser.analyse_sentence("@user 오글오긄거려섴ㅋㅋㅋㅋㅋㅋ")
    #                           end
    # test "@user (차에서 폴짝 내린다)" do
    #                          assert_value KoreanSentenceAnalyser.analyse_sentence("@user (차에서 폴짝 내린다)")
    #                          end
    # test "@user 언닌 공부를 햇나바여....난 바로 퇴출당할뜻...." do
    #                                           assert_value KoreanSentenceAnalyser.analyse_sentence("@user 언닌 공부를 햇나바여....난 바로 퇴출당할뜻....")
    #                                           end
    # test "크브스가 보라는 제일낫네.. 엠비씨 왜이럼" do
    #                               assert_value KoreanSentenceAnalyser.analyse_sentence("크브스가 보라는 제일낫네.. 엠비씨 왜이럼")
    #                               end
    # test "시발 ㅠ 나 탈덕할꺼야 시발 시발아 시발아아아아시발아ㅠㅠㅠㅠㅠㅠㅠㅠㅠ" do
    #                                              assert_value KoreanSentenceAnalyser.analyse_sentence("시발 ㅠ 나 탈덕할꺼야 시발 시발아 시발아아아아시발아ㅠㅠㅠㅠㅠㅠㅠㅠㅠ")
    #                                              end
    # test "@user ㅇㅁㅇ안알랴죠" do
    #                     assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅇㅁㅇ안알랴죠")
    #                     end
    # test "“@user: 이번에 광주 시장;;;밀실 공천이니 전략공천이니 말 많았는데 결국은 새민련이 됐으니;;;;더 무시 당할수도;;;;;정신 차려야 되는디;;하아...걱정이다;;;;” 선택의 여지가 없었죠 ㅠㅠㅠㅠ" do
    #                                                                                                                           assert_value KoreanSentenceAnalyser.analyse_sentence("“@user: 이번에 광주 시장;;;밀실 공천이니 전략공천이니 말 많았는데 결국은 새민련이 됐으니;;;;더 무시 당할수도;;;;;정신 차려야 되는디;;하아...걱정이다;;;;” 선택의 여지가 없었죠 ㅠㅠㅠㅠ")
    #                                                                                                                           end
    # test "“@user: [박영선 원내대표실] 박영선 원내대표 "국민 여러분, 가만히 있으면 안 됩니다. 투표해 주십시오!"" do
    #                                                                       assert_value KoreanSentenceAnalyser.analyse_sentence("“@user: [박영선 원내대표실] 박영선 원내대표 "국민 여러분, 가만히 있으면 안 됩니다. 투표해 주십시오!"")
    #                                                                       end
    #                                          test "첫인상: 여성분이신가 두근 여성분에 마를렌 하시면 짱귀여운 분이겠지!!" do
    #                                                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("첫인상: 여성분이신가 두근 여성분에 마를렌 하시면 짱귀여운 분이겠지!!")
    #                                                                                         end
    #                                          test "@user 오랜만이지? 어? 반갑지? (키득 웃음)" do
    #                                                                              assert_value KoreanSentenceAnalyser.analyse_sentence("@user 오랜만이지? 어? 반갑지? (키득 웃음)")
    #                                                                              end
    #                                          test "@user 헉!!치즈의향연!!역시치즈는ㅠㅠ존맛ㅠㅠ" do
    #                                                                             assert_value KoreanSentenceAnalyser.analyse_sentence("@user 헉!!치즈의향연!!역시치즈는ㅠㅠ존맛ㅠㅠ")
    #                                                                             end
    #                                          test "@user 흥 몰라 훈제 되어주지!" do
    #                                                                     assert_value KoreanSentenceAnalyser.analyse_sentence("@user 흥 몰라 훈제 되어주지!")
    #                                                                     end
    #                                          test "무료야동보는곳 http://link.com" do
    #                                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("무료야동보는곳 http://link.com")
    #                                                                         end
    #                                          test "@user 이렇게 예쁜걸! 찌찌가리개 어깨왕자로 바꿔버리다니! 디자인 누구야!(엎 http://link.com" do
    #                                                                                                               assert_value KoreanSentenceAnalyser.analyse_sentence("@user 이렇게 예쁜걸! 찌찌가리개 어깨왕자로 바꿔버리다니! 디자인 누구야!(엎 http://link.com")
    #                                                                                                               end
    #                                          test "6·4 지방선거의 투표 마감이 이제 얼마남지 않았는데요. 투표소에는 막바지 유권자들이 발걸음이 이어지고 있다고 합니다. http://link.com" do
    #                                                                                                                                    assert_value KoreanSentenceAnalyser.analyse_sentence("6·4 지방선거의 투표 마감이 이제 얼마남지 않았는데요. 투표소에는 막바지 유권자들이 발걸음이 이어지고 있다고 합니다. http://link.com")
    #                                                                                                                                    end
    #                                          test "@user ㅋㅋㅋ안녕하세요 잘주무셨나요??투표는 하셨나요??" do
    #                                                                                   assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅋㅋㅋ안녕하세요 잘주무셨나요??투표는 하셨나요??")
    #                                                                                   end
    #                                          test "@user 보내주thㅔ요... (됴들)" do
    #                                                                       assert_value KoreanSentenceAnalyser.analyse_sentence("@user 보내주thㅔ요... (됴들)")
    #                                                                       end
    #                                          test "Opera, eres mi salvación" do
    #                                                                          assert_value KoreanSentenceAnalyser.analyse_sentence("Opera, eres mi salvación")
    #                                                                          end
    #                                          test "@user 남은 하루를 행복하게 보낼 수 있습니다..." do
    #                                                                                assert_value KoreanSentenceAnalyser.analyse_sentence("@user 남은 하루를 행복하게 보낼 수 있습니다...")
    #                                                                                end
    #                                          test "@user 삼연. . 삼연을 기다려요" do
    #                                                                      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 삼연. . 삼연을 기다려요")
    #                                                                      end
    #                                          test "영어 http://link.com" do
    #                                                                    assert_value KoreanSentenceAnalyser.analyse_sentence("영어 http://link.com")
    #                                                                    end
    #                                          test "레드그레이브는 아직 인형 안 됐잖아 ㅡㅡ" do
    #                                                                        assert_value KoreanSentenceAnalyser.analyse_sentence("레드그레이브는 아직 인형 안 됐잖아 ㅡㅡ")
    #                                                                        end
    #                                          test "@user 난 월남쌈 해먹어썽 ㅋㅋㅋ 일하는데 어디야?? ㅋㅋ 지에스에 개맛있는 샌드위치 이떠라ㅠㅠ" do
    #                                                                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user 난 월남쌈 해먹어썽 ㅋㅋㅋ 일하는데 어디야?? ㅋㅋ 지에스에 개맛있는 샌드위치 이떠라ㅠㅠ")
    #                                                                                                         end
    #                                          test "하릇밤 3만원.. 어라? 세상에" do
    #                                                                   assert_value KoreanSentenceAnalyser.analyse_sentence("하릇밤 3만원.. 어라? 세상에")
    #                                                                   end
    #                                          test "@user 죄송해오ㅜㅠ" do
    #                                                              assert_value KoreanSentenceAnalyser.analyse_sentence("@user 죄송해오ㅜㅠ")
    #                                                              end
    #                                          test "인라인대결!! 우현이빼곤 딱히 절친이 누구인지 몰라서 더 재밌을듯ㅋㅋㅋ 광고보고 라비가 만든 로고송 놓치지 말고 들어야지!!♥" do
    #                                                                                                                        assert_value KoreanSentenceAnalyser.analyse_sentence("인라인대결!! 우현이빼곤 딱히 절친이 누구인지 몰라서 더 재밌을듯ㅋㅋㅋ 광고보고 라비가 만든 로고송 놓치지 말고 들어야지!!♥")
    #                                                                                                                        end
    #                                          test "@user 봇이랑 ㄱ간간히 인터뷰번역같은데서 줏어들었어요... 자까님 그리고싶으신건많은데 그릴기회가 없으신거같아요...그냥 본편에넣으면되잖아!! 경기끝나고 보내주면되잖아ㅠㅠ!! (ㄱ갤뒤적)" do
    #                                                                                                                                                           assert_value KoreanSentenceAnalyser.analyse_sentence("@user 봇이랑 ㄱ간간히 인터뷰번역같은데서 줏어들었어요... 자까님 그리고싶으신건많은데 그릴기회가 없으신거같아요...그냥 본편에넣으면되잖아!! 경기끝나고 보내주면되잖아ㅠㅠ!! (ㄱ갤뒤적)")
    #                                                                                                                                                           end
    #                                          test "@user 우리드콘에서만나여..." do
    #                                                                    assert_value KoreanSentenceAnalyser.analyse_sentence("@user 우리드콘에서만나여...")
    #                                                                    end
    #                                          test "ผช. ที่ชื่อ มยองซู นี่ยังไหวอยู่มั้ยคะ 555555 140604 애프터스쿨클럽 인피니트 by플로라: http://link.com" do
    #                                                                                                                                          assert_value KoreanSentenceAnalyser.analyse_sentence("ผช. ที่ชื่อ มยองซู นี่ยังไหวอยู่มั้ยคะ 555555 140604 애프터스쿨클럽 인피니트 by플로라: http://link.com")
    #                                                                                                                                          end
    #                                          test "[본문스크랩] 쪽파무침 ♩ 간단한 쪽파요리 별미 반찬 http://link.com 출처 : 네이버 블로그" do
    #                                                                                                            assert_value KoreanSentenceAnalyser.analyse_sentence("[본문스크랩] 쪽파무침 ♩ 간단한 쪽파요리 별미 반찬 http://link.com 출처 : 네이버 블로그")
    #                                                                                                            end
    #                                          test "http://link.com ★ [iOS7에 어울리는 배경화면] 배경이미지 wallpaper 월페이퍼  #토익과외 #toeic #sat" do
    #                                                                                                                             assert_value KoreanSentenceAnalyser.analyse_sentence("http://link.com ★ [iOS7에 어울리는 배경화면] 배경이미지 wallpaper 월페이퍼  #토익과외 #toeic #sat")
    #                                                                                                                             end
    #                                          test "리니어스랑 싸우는데 뭐가뭔지 하나도 모르겠다 짜증난다" do
    #                                                                               assert_value KoreanSentenceAnalyser.analyse_sentence("리니어스랑 싸우는데 뭐가뭔지 하나도 모르겠다 짜증난다")
    #                                                                               end
    #                                          test "@user 허ㅓ허 제가 그렇게 좋으셨다니~!ㅇ.&lt;☞☞♡♡♥ (찡긋" do
    #                                                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user 허ㅓ허 제가 그렇게 좋으셨다니~!ㅇ.&lt;☞☞♡♡♥ (찡긋")
    #                                                                                         end
    #                                          test "@user 학 나도이귱언니좋아..♡" do
    #                                                                     assert_value KoreanSentenceAnalyser.analyse_sentence("@user 학 나도이귱언니좋아..♡")
    #                                                                     end
    #                                          test "빛이되어줘 ยูควอนโฟกัส เลอค่า" do
    #                                                                          assert_value KoreanSentenceAnalyser.analyse_sentence("빛이되어줘 ยูควอนโฟกัส เลอค่า")
    #                                                                          end
    #                                          test "잘먹겠습니다!!!!배짱많이고팠는데 누나들 진짜 사랑해요!!!ㅎㅎ이따 저녁에또뵈요~!!!ㅎㅎ http://link.com" do
    #                                                                                                                    assert_value KoreanSentenceAnalyser.analyse_sentence("잘먹겠습니다!!!!배짱많이고팠는데 누나들 진짜 사랑해요!!!ㅎㅎ이따 저녁에또뵈요~!!!ㅎㅎ http://link.com")
    #                                                                                                                    end
    #                                          test "@user 응 지금 먹으러가! 나중에봐!" do
    #                                                                        assert_value KoreanSentenceAnalyser.analyse_sentence("@user 응 지금 먹으러가! 나중에봐!")
    #                                                                        end
    #                                          test "@user ...@ㅅ@" do
    #                                                              assert_value KoreanSentenceAnalyser.analyse_sentence("@user ...@ㅅ@")
    #                                                              end
    #                                          test "@user 데이트 생각으로 잠을 못이루겠군.. ^오^" do
    #                                                                               assert_value KoreanSentenceAnalyser.analyse_sentence("@user 데이트 생각으로 잠을 못이루겠군.. ^오^")
    #                                                                               end
    #                                          test "언제쯤 내 맘을 들을 수 있을까 가끔씩은 혼자 울기도 해" do
    #                                                                                 assert_value KoreanSentenceAnalyser.analyse_sentence("언제쯤 내 맘을 들을 수 있을까 가끔씩은 혼자 울기도 해")
    #                                                                                 end
    #                                          test "@user 애깅." do
    #                                                           assert_value KoreanSentenceAnalyser.analyse_sentence("@user 애깅.")
    #                                                           end
    #                                          test "@user 꺄아ㅏ아ㅏ아ㅏㅇ아아ㅏ아ㅏㅇ 애슐리갔어???????" do
    #                                                                                   assert_value KoreanSentenceAnalyser.analyse_sentence("@user 꺄아ㅏ아ㅏ아ㅏㅇ아아ㅏ아ㅏㅇ 애슐리갔어???????")
    #                                                                                   end
    #                                          test "RT @user: 문디 자슥들 고창궈이 사퇴했다고 그리 뉴스를 뉴스를 했는데 고창궈이 찍고 앉았노" do
    #                                                                                                        assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 문디 자슥들 고창궈이 사퇴했다고 그리 뉴스를 뉴스를 했는데 고창궈이 찍고 앉았노")
    #                                                                                                        end
    #                                          test "@user 오늘 내로 게임이 끝나지 않을 경우도 전원 벌칙?" do
    #                                                                                   assert_value KoreanSentenceAnalyser.analyse_sentence("@user 오늘 내로 게임이 끝나지 않을 경우도 전원 벌칙?")
    #                                                                                   end
    #                                          test "'골든 크로스' 폭풍 리뷰 쓰고 이제 잘려고 준비 중. 아 피곤하지만 않으면 더 잘 쓸 수 있는데 엉어어링러ㅣㄴㅇ" do
    #                                                                                                                 assert_value KoreanSentenceAnalyser.analyse_sentence("'골든 크로스' 폭풍 리뷰 쓰고 이제 잘려고 준비 중. 아 피곤하지만 않으면 더 잘 쓸 수 있는데 엉어어링러ㅣㄴㅇ")
    #                                                                                                                 end
    #                                          test "선배 말에 의하면 우리과 교수님이 수업중에 "어차피 니들은 여자 남자같은거 관심없고 집에 다키마쿠라 모셔두고 그러지?ㅋㅋ?"라고 하자 다들 のヮの표정을 지었고(?)울 교수님들은 저작권 관련 수업 자료로 니코동 애니매드를 쓰곤 하신다(학과가 통쨰로 덕후" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("선배 말에 의하면 우리과 교수님이 수업중에 "어차피 니들은 여자 남자같은거 관심없고 집에 다키마쿠라 모셔두고 그러지?ㅋㅋ?"라고 하자 다들 のヮの표정을 지었고(?)울 교수님들은 저작권 관련 수업 자료로 니코동 애니매드를 쓰곤 하신다(학과가 통쨰로 덕후")
    #    end
    #    test "헐 카타장인 윤귀중 리게이였음??? 문화컬쳐다 ㅋㅋㅋㅋㅋ" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("헐 카타장인 윤귀중 리게이였음??? 문화컬쳐다 ㅋㅋㅋㅋㅋ")
    #    end
    #    test "우왓!!! 멋진 날개다!! @user" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("우왓!!! 멋진 날개다!! @user")
    #    end
    #    test "profusion 다량, 풍성함" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("profusion 다량, 풍성함")
    #    end
    #    test "@user 아이거참 너무하네!" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 아이거참 너무하네!")
    #    end
    #    test "@user 얼마생각하세요" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 얼마생각하세요")
    #    end
    #    test "@user ㅋㅋㅋ사진으로 뭘 그리냐? 가서 앉아있어. 원하는 포즈있음, 그걸로 하고." do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅋㅋㅋ사진으로 뭘 그리냐? 가서 앉아있어. 원하는 포즈있음, 그걸로 하고.")
    #    end
    #    test "저 50분동안 고통받아서 잠시 쉬고오겠습니다......" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("저 50분동안 고통받아서 잠시 쉬고오겠습니다......")
    #    end
    #    test "@user @user @user @user @user @user @user 꺅!!!1위!!!축하해요오ㅠㅠ♥♥항상미안하고고마워ㅠㅠ♥" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user @user @user @user @user @user 꺅!!!1위!!!축하해요오ㅠㅠ♥♥항상미안하고고마워ㅠㅠ♥")
    #    end
    #    test "@user 오빠 여기 어디에용?" do
    #                             assert_value KoreanSentenceAnalyser.analyse_sentence("@user 오빠 여기 어디에용?")
    #                             end
    #                                                                                           test "RT @user: 투표 마감 시간은 6시!" do
    #                                                                                                                          assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 투표 마감 시간은 6시!")
    #                                                                                                                          end
    #                                                                                           test "@user ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ 얘 왜이래 야 너 어디 아프냐??? 채소사줄까????" do
    #                                                                                                                                                 assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ 얘 왜이래 야 너 어디 아프냐??? 채소사줄까????")
    #                                                                                                                                                 end
    # test "@user 부정하지않아도되여&gt;_&lt;ㅋㅋㅋㅋ" do
    #                                    assert_value KoreanSentenceAnalyser.analyse_sentence("@user 부정하지않아도되여&gt;_&lt;ㅋㅋㅋㅋ")
    #                                    end
    # test "...자, 그래서. 갑자기 왜 대화가 보이지 않는지 아는 사람 있나." do
    #                                              assert_value KoreanSentenceAnalyser.analyse_sentence("...자, 그래서. 갑자기 왜 대화가 보이지 않는지 아는 사람 있나.")
    #                                              end
    # test "@user 유전ㄴ자조작ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅈㄹㅋㅋㅋㅋㅋㅋㅋㅋ난그럼 어른이니까 더ㅓ잇어도되겠지" do
    #                                                               assert_value KoreanSentenceAnalyser.analyse_sentence("@user 유전ㄴ자조작ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅈㄹㅋㅋㅋㅋㅋㅋㅋㅋ난그럼 어른이니까 더ㅓ잇어도되겠지")
    #                                                               end
    # test "@user 부인이요?저도있는ㄴ데여.....;" do
    #                                assert_value KoreanSentenceAnalyser.analyse_sentence("@user 부인이요?저도있는ㄴ데여.....;")
    #                                end
    # test "@user 툽님이 참여하셨다니............. 제가진자스크롤내리다가 완전 아...완전뭐랄까 막..... 감동이막..와지짜넘멋졋자나여..... 하지쨔...아이..하..아..안엉...으헣 휴ㅠㅠㅠ툽님감사합니다 ㅏㅎ트하트" do
    #                                                                                                                                    assert_value KoreanSentenceAnalyser.analyse_sentence("@user 툽님이 참여하셨다니............. 제가진자스크롤내리다가 완전 아...완전뭐랄까 막..... 감동이막..와지짜넘멋졋자나여..... 하지쨔...아이..하..아..안엉...으헣 휴ㅠㅠㅠ툽님감사합니다 ㅏㅎ트하트")
    #                                                                                                                                    end
    # test "@user 애기젖내 쬬아!" do
    #                      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 애기젖내 쬬아!")
    #                      end
    # test "저는 1,473의 식량을 수확했어요! http://link.com #iphone, #iphonegames, #gameinsight" do
    #                                                                                assert_value KoreanSentenceAnalyser.analyse_sentence("저는 1,473의 식량을 수확했어요! http://link.com #iphone, #iphonegames, #gameinsight")
    #                                                                                end
    # test "춘몽님.. 와대로 가서 터뜨릴까 아니면 야당같지않은 넘들 먼저 죽일까나.." do
    #                                                 assert_value KoreanSentenceAnalyser.analyse_sentence("춘몽님.. 와대로 가서 터뜨릴까 아니면 야당같지않은 넘들 먼저 죽일까나..")
    #                                                 end
    # test "현우오빠가 가장좋아해&gt;__&lt;♡♡" do
    #                               assert_value KoreanSentenceAnalyser.analyse_sentence("현우오빠가 가장좋아해&gt;__&lt;♡♡")
    #                               end
    # test ""@user: 오거돈이 부산시장되면 롯데한테 져도 화안낼거같아" 제발~!!!!" do
    #                                                   assert_value KoreanSentenceAnalyser.analyse_sentence(""@user: 오거돈이 부산시장되면 롯데한테 져도 화안낼거같아" 제발~!!!!")
    #                                                   end
    #                                         test "@user 히이이이이잌..." do
    #                                                                assert_value KoreanSentenceAnalyser.analyse_sentence("@user 히이이이이잌...")
    #                                                                end
    #                                         test "@user 난 내가 제작했던것들.. 판매계했던거 존나 흑역사ㅋㅋㅋㅋㅋㅋㅋㅋㅋ" do
    #                                                                                           assert_value KoreanSentenceAnalyser.analyse_sentence("@user 난 내가 제작했던것들.. 판매계했던거 존나 흑역사ㅋㅋㅋㅋㅋㅋㅋㅋㅋ")
    #                                                                                           end
    #                                         test "@user 휴 전 오늘 여기서 누울게요... 케님의 러버가 되었다...!" do
    #                                                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user 휴 전 오늘 여기서 누울게요... 케님의 러버가 되었다...!")
    #                                                                                         end
    #                                         test "와근데 울하꾜애들 쩐다 꾸미려는ㄴ의지가 조금도없음" do
    #                                                                            assert_value KoreanSentenceAnalyser.analyse_sentence("와근데 울하꾜애들 쩐다 꾸미려는ㄴ의지가 조금도없음")
    #                                                                            end
    # test "@user @user 맞아맞아!!!! 이번엔ㅋㅋㅋㅋㅋㅋㅋㅋ어둠을 가득 담은 글이지만ㅠㅠㅠㅠㅠ근데 나레기 달달고자라눙ㅎ.ㅎ 달달능력을 키워야게쩌" do
    #                                                                                       assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user 맞아맞아!!!! 이번엔ㅋㅋㅋㅋㅋㅋㅋㅋ어둠을 가득 담은 글이지만ㅠㅠㅠㅠㅠ근데 나레기 달달고자라눙ㅎ.ㅎ 달달능력을 키워야게쩌")
    #                                                                                       end
    #                                                                                       test "편백 도마가 왔다아~ 편백은 천연항균. 물에 헹궤 놔두면 좋은 향 (히노끼 사우나 냄새)이 나서 부엌에 세균 다 잡아먹어줄것 같음. http://link.com" do
    #                                                                                                                                                                                        assert_value KoreanSentenceAnalyser.analyse_sentence("편백 도마가 왔다아~ 편백은 천연항균. 물에 헹궤 놔두면 좋은 향 (히노끼 사우나 냄새)이 나서 부엌에 세균 다 잡아먹어줄것 같음. http://link.com")
    #                                                                                                                                                                                        end
    #                                                                                       test ""음, 기분 최고야." #the_Glorious_Executioner" do
    #                                                                                                                                     assert_value KoreanSentenceAnalyser.analyse_sentence(""음, 기분 최고야." #the_Glorious_Executioner")
    #                                                                                                                                     end
    #                                                                                       test "@user 그거 그냥 저장 안하고 나가면 되는데.... 심 삭제 된 케이스면 그 이사하기로 어케어케 하면 다시 돌아오기도 함 ㅇㅇ 심한테 전화해서 놀러오기 시켜봐" do
    #                                                                                                                                                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user 그거 그냥 저장 안하고 나가면 되는데.... 심 삭제 된 케이스면 그 이사하기로 어케어케 하면 다시 돌아오기도 함 ㅇㅇ 심한테 전화해서 놀러오기 시켜봐")
    #                                                                                                                                                                                         end
    #                                                                                       test "@user 88 저두.. 괜찮아요 ㅈ ㅏ희에겐 트이터가 있으니ㄲ!!(안괜찮" do
    #                                                                                                                                        assert_value KoreanSentenceAnalyser.analyse_sentence("@user 88 저두.. 괜찮아요 ㅈ ㅏ희에겐 트이터가 있으니ㄲ!!(안괜찮")
    #                                                                                                                                        end
    # test "@user 대박ㄱ대박" do
    #                   assert_value KoreanSentenceAnalyser.analyse_sentence("@user 대박ㄱ대박")
    #                   end
    # test "웃음 없는 하루는, 그 날 하루를 낭비한 것이다. 찰리 채플린의 말이야. 오늘 하룻동안 자기는 얼마나 많이 웃었어? 나한테만 그 예쁜 미소 보여주지 말고 다른 사람한테도 좀 보여줘. 나도 자랑 좀 하자." do
    #                                                                                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("웃음 없는 하루는, 그 날 하루를 낭비한 것이다. 찰리 채플린의 말이야. 오늘 하룻동안 자기는 얼마나 많이 웃었어? 나한테만 그 예쁜 미소 보여주지 말고 다른 사람한테도 좀 보여줘. 나도 자랑 좀 하자.")
    #                                                                                                                         end
    # test "@user 그럼 야채호빵," do
    #                      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 그럼 야채호빵,")
    #                      end
    # test "@user 송호창 왜 그럼? 밥값도 못하고" do
    #                               assert_value KoreanSentenceAnalyser.analyse_sentence("@user 송호창 왜 그럼? 밥값도 못하고")
    #                               end
    # test "-서울 중구 장충동 제2투표소 가보니...http://link.com" do
    #                                              assert_value KoreanSentenceAnalyser.analyse_sentence("-서울 중구 장충동 제2투표소 가보니...http://link.com")
    #                                              end
    # test "@user 0ㅁ0 저 그러면 영생을 누릴지도요...?" do
    #                                     assert_value KoreanSentenceAnalyser.analyse_sentence("@user 0ㅁ0 저 그러면 영생을 누릴지도요...?")
    #                                     end
    # test "@user 발랑가 해금 긍방 되던데" do
    #                           assert_value KoreanSentenceAnalyser.analyse_sentence("@user 발랑가 해금 긍방 되던데")
    #                           end
    # test "@user 농담 이고  기력이 너무 많아서  안 나오는 듯한 &gt;&lt;   그렸으므로  모 다이죠부~!" do
    #                                                                    assert_value KoreanSentenceAnalyser.analyse_sentence("@user 농담 이고  기력이 너무 많아서  안 나오는 듯한 &gt;&lt;   그렸으므로  모 다이죠부~!")
    #                                                                    end
    # test "@user 후우웅.. 시간이 얼마 없당.." do
    #                               assert_value KoreanSentenceAnalyser.analyse_sentence("@user 후우웅.. 시간이 얼마 없당..")
    #                               end
    # test "@user 까먹어서...ㅇ.. 안볼듯 별박으나 마나.." do
    #                                      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 까먹어서...ㅇ.. 안볼듯 별박으나 마나..")
    #                                      end
    # test "@user 네가 단 한 마디만 해주면 되 , 딱 한번만 용기를 내줘. 그 이후 나머지는 내가 이어서 할테니까." do
    #                                                                     assert_value KoreanSentenceAnalyser.analyse_sentence("@user 네가 단 한 마디만 해주면 되 , 딱 한번만 용기를 내줘. 그 이후 나머지는 내가 이어서 할테니까.")
    #                                                                     end
    # test "@user #LastRomeo #인피니트 /중복참여! http://link.com" do
    #                                                     assert_value KoreanSentenceAnalyser.analyse_sentence("@user #LastRomeo #인피니트 /중복참여! http://link.com")
    #                                                     end
    # test "@user 아냐-. (그의 품에서 바르작거린다.) 진짜 안들어가. (입술 내미는 그를 보고 푸흐흐 웃어) 응, 뽀- (같이 입술을 내민다)" do
    #                                                                                     assert_value KoreanSentenceAnalyser.analyse_sentence("@user 아냐-. (그의 품에서 바르작거린다.) 진짜 안들어가. (입술 내미는 그를 보고 푸흐흐 웃어) 응, 뽀- (같이 입술을 내민다)")
    #                                                                                     end
    # test "@user ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ 렌까지 나오니까 놀라긴 놀라는데 뭐라고 얘기 더 나오기 전에 더든이 먼저 법적대응 얘기부터 시작해서 이런 일 시작하면 그쪽이 더 불리하다 하면서 상대가 더러워서 피하게 할거 같아요()" do
    #                                                                                                                                               assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ 렌까지 나오니까 놀라긴 놀라는데 뭐라고 얘기 더 나오기 전에 더든이 먼저 법적대응 얘기부터 시작해서 이런 일 시작하면 그쪽이 더 불리하다 하면서 상대가 더러워서 피하게 할거 같아요()")
    #                                                                                                                                               end
    # test "좋은 아침! 오늘은 뭐 먹을거야? 아,왠만하면 아침은 꼭 챙겨먹자.배고파하는 너도 귀엽지만 아침은 먹어야 건강에 좋대~" do
    #                                                                          assert_value KoreanSentenceAnalyser.analyse_sentence("좋은 아침! 오늘은 뭐 먹을거야? 아,왠만하면 아침은 꼭 챙겨먹자.배고파하는 너도 귀엽지만 아침은 먹어야 건강에 좋대~")
    #                                                                          end
    # test "@user 그건 다른분이시고 이분은 리믹스하신분" do
    #                                  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 그건 다른분이시고 이분은 리믹스하신분")
    #                                  end
    # test "@user 절라설레여요" do
    #                    assert_value KoreanSentenceAnalyser.analyse_sentence("@user 절라설레여요")
    #                    end
    # test "음양군, 회사일이라고하며 밖으로 내빼는 영상을 어디사는 누군가가 제보했더군요. 한번 더 걸리면 손모가지입니다." do
    #                                                                     assert_value KoreanSentenceAnalyser.analyse_sentence("음양군, 회사일이라고하며 밖으로 내빼는 영상을 어디사는 누군가가 제보했더군요. 한번 더 걸리면 손모가지입니다.")
    #                                                                     end
    # test "@user 우왕 블소인가요?? 저도 하고싶ㅠㅠㅠ은 컴퓨터 부터 바꿔야..8ㅁ8!!" do
    #                                                     assert_value KoreanSentenceAnalyser.analyse_sentence("@user 우왕 블소인가요?? 저도 하고싶ㅠㅠㅠ은 컴퓨터 부터 바꿔야..8ㅁ8!!")
    #                                                     end
    # test "@user 아니 ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ대전 못갘ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ지갑 찢어짐ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ" do
    #                                                                                          assert_value KoreanSentenceAnalyser.analyse_sentence("@user 아니 ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ대전 못갘ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ지갑 찢어짐ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ")
    #                                                                                          end
    # test "@user 어, 경계하지 않아도 되는데. (베시시 웃어)" do
    #                                       assert_value KoreanSentenceAnalyser.analyse_sentence("@user 어, 경계하지 않아도 되는데. (베시시 웃어)")
    #                                       end
    # test "@user 어떻게 자세히 아는거징?!" do
    #                            assert_value KoreanSentenceAnalyser.analyse_sentence("@user 어떻게 자세히 아는거징?!")
    #                            end
    # test "왜 없는척ㅇ했음!@!!!!@(?)" do
    #                          assert_value KoreanSentenceAnalyser.analyse_sentence("왜 없는척ㅇ했음!@!!!!@(?)")
    #                          end
    # test "망했다 난 오늘 잠을 못잘것이닼ㅋㅋㅋㅋㅋㅋㅋㅋㅋ" do
    #                                  assert_value KoreanSentenceAnalyser.analyse_sentence("망했다 난 오늘 잠을 못잘것이닼ㅋㅋㅋㅋㅋㅋㅋㅋㅋ")
    #                                  end
    # test "@user ????????6월다음 7월인데" do
    #                               assert_value KoreanSentenceAnalyser.analyse_sentence("@user ????????6월다음 7월인데")
    #                               end
    # test "잘하고 있어 함께 있어줘 내게로 들려 네가 들려 say hello hello hello hello 두눈으로 널 볼 수 있고 두 팔로 널 안을 수 있어 더 가까이서 또 들려오는 너의 목소리 hello*4 - 신화, On the Road♪" do
    #                                                                                                                                           assert_value KoreanSentenceAnalyser.analyse_sentence("잘하고 있어 함께 있어줘 내게로 들려 네가 들려 say hello hello hello hello 두눈으로 널 볼 수 있고 두 팔로 널 안을 수 있어 더 가까이서 또 들려오는 너의 목소리 hello*4 - 신화, On the Road♪")
    #                                                                                                                                           end
    # test "AKITO - 櫻華月(앵화월, SakuraKagetsu) / 장르 : Jp-Spiritual pop // 벚나무와 달 이라는 제목에 걸맞게 일본풍의 전통적인 멜로디, 중간에 들리는 신스음이 노래의 분위기와 어우러져 몽환적인 느낌을 살린 곡입니다." do
    #                                                                                                                                                 assert_value KoreanSentenceAnalyser.analyse_sentence("AKITO - 櫻華月(앵화월, SakuraKagetsu) / 장르 : Jp-Spiritual pop // 벚나무와 달 이라는 제목에 걸맞게 일본풍의 전통적인 멜로디, 중간에 들리는 신스음이 노래의 분위기와 어우러져 몽환적인 느낌을 살린 곡입니다.")
    #                                                                                                                                                 end
    # test "@user 화끈한 남자!!!!!" do
    #                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user 화끈한 남자!!!!!")
    #                         end
    # test "@user 통장 털려고?" do
    #                     assert_value KoreanSentenceAnalyser.analyse_sentence("@user 통장 털려고?")
    #                     end
    # test "결혼 강의 이래로 최초의 남남 커플이라 둘 다 안 들으려는데 학점 때문에 드랍도 못하고 강의를 계속 들어야 하는 상황. 과제로 데이트를 하라고 해서 만나긴 했는데 무슨 데이트야 싶고.. 그러다가 따로 계속 만나고 연애를 하고.." do
    #                                                                                                                                       assert_value KoreanSentenceAnalyser.analyse_sentence("결혼 강의 이래로 최초의 남남 커플이라 둘 다 안 들으려는데 학점 때문에 드랍도 못하고 강의를 계속 들어야 하는 상황. 과제로 데이트를 하라고 해서 만나긴 했는데 무슨 데이트야 싶고.. 그러다가 따로 계속 만나고 연애를 하고..")
    #                                                                                                                                       end
    # test "@user 관광버스로 내부 개조하셨나여" do
    #                             assert_value KoreanSentenceAnalyser.analyse_sentence("@user 관광버스로 내부 개조하셨나여")
    #                             end
    # test "@user @user @user 그래도 궁굼한데~ 어떤 분류인지만 말해주면 안되?! 응?!" do
    #                                                          assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user @user 그래도 궁굼한데~ 어떤 분류인지만 말해주면 안되?! 응?!")
    #                                                          end
    # test "@user 헐 짜증나겠다ㅡㅡ" do
    #                       assert_value KoreanSentenceAnalyser.analyse_sentence("@user 헐 짜증나겠다ㅡㅡ")
    #                       end
    # test "@user 욧페이 구루욧틴 존잘님" do
    #                          assert_value KoreanSentenceAnalyser.analyse_sentence("@user 욧페이 구루욧틴 존잘님")
    #                          end
    # test "@user @user ㅁㅊ ㄷㄷㄷ 24시간 안에 다 봐야해" do
    #                                        assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user ㅁㅊ ㄷㄷㄷ 24시간 안에 다 봐야해")
    #                                        end
    # test "@user 내전화를 왜 거절해?ㅋㅋㅋㅋ" do
    #                             assert_value KoreanSentenceAnalyser.analyse_sentence("@user 내전화를 왜 거절해?ㅋㅋㅋㅋ")
    #                             end
    # test "@user 왜 내가 멋있어?" do
    #                       assert_value KoreanSentenceAnalyser.analyse_sentence("@user 왜 내가 멋있어?")
    #                       end
    # test "로버트 쉴러의 '새로운 금융시대'가 왔다. 재무 공부하는 사람 입장으로서 추천." do
    #                                                    assert_value KoreanSentenceAnalyser.analyse_sentence("로버트 쉴러의 '새로운 금융시대'가 왔다. 재무 공부하는 사람 입장으로서 추천.")
    #                                                    end
    # test ""요동친다 하트! 불타버릴만큼 히트! 우오오오 새긴다! 혈액의비트! 선라이트 옐로 오버드라이브!!!" (황금빛 파문질주) 죠죠의기묘한모험中 죠나단죠스타" do
    #                                                                                            assert_value KoreanSentenceAnalyser.analyse_sentence(""요동친다 하트! 불타버릴만큼 히트! 우오오오 새긴다! 혈액의비트! 선라이트 옐로 오버드라이브!!!" (황금빛 파문질주) 죠죠의기묘한모험中 죠나단죠스타")
    #                                                                                            end
    #                                                              test "@user .....미, 미안해요..." do
    #                                                                                           assert_value KoreanSentenceAnalyser.analyse_sentence("@user .....미, 미안해요...")
    #                                                                                           end
    #                                                              test "@user ㅋㅋㅋ &gt;_&lt;" do
    #                                                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅋㅋㅋ &gt;_&lt;")
    #                                                                                         end
    #                                                              test "@user 애 태우는 게 전문이라." do
    #                                                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user 애 태우는 게 전문이라.")
    #                                                                                         end
    #                                                              test "저는 18,402개의 금화를 모았어요! http://link.com #android, #androidgames, #gameinsight" do
    #                                                                                                                                                 assert_value KoreanSentenceAnalyser.analyse_sentence("저는 18,402개의 금화를 모았어요! http://link.com #android, #androidgames, #gameinsight")
    #                                                                                                                                                 end
    # test "@user @user ㅋㅋㅋㅋㅋㅋㅋ옆에있던 헨리횽한테도 고맙다고 전해줘욬ㅋㅋㅋㅋㅋㅋ음주하신줄ㅋㅋㅋ재밌었어요ㅋㅋㅋ호워나 윤도형님 좋은 친분 쭉 유지해~ 재밌는 분이넼ㅋㅋㅋ아 계속생각나ㅋㅋㅋㅋㅋ" do
    #                                                                                                                  assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user ㅋㅋㅋㅋㅋㅋㅋ옆에있던 헨리횽한테도 고맙다고 전해줘욬ㅋㅋㅋㅋㅋㅋ음주하신줄ㅋㅋㅋ재밌었어요ㅋㅋㅋ호워나 윤도형님 좋은 친분 쭉 유지해~ 재밌는 분이넼ㅋㅋㅋ아 계속생각나ㅋㅋㅋㅋㅋ")
    #                                                                                                                  end
    # test "@user ㅋㅋㅋㅋㅋㅋㅋㅋ알았어요 안그럴게욬ㅋㅋㅋㅋㅋㅋㄱㅋㅋㄱㅋㅋㅋㅋㅋㅋㅋㅋㅋ사실더개롭히구싶지만 헤헤..." do
    #                                                                   assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅋㅋㅋㅋㅋㅋㅋㅋ알았어요 안그럴게욬ㅋㅋㅋㅋㅋㅋㄱㅋㅋㄱㅋㅋㅋㅋㅋㅋㅋㅋㅋ사실더개롭히구싶지만 헤헤...")
    #                                                                   end
    # test "@user 꼭필요하신분만 ㅇㅇㅇ알티해주신분들에게드릴게요" do
    #                                      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 꼭필요하신분만 ㅇㅇㅇ알티해주신분들에게드릴게요")
    #                                      end
    # test "@user 나름 긍정적인걸. 그래도 확실히 혼자보단 여럿이서 있는데 안심되기는 하니까. 너무 몰려있는건 안좋다고 생각하지만." do
    #                                                                             assert_value KoreanSentenceAnalyser.analyse_sentence("@user 나름 긍정적인걸. 그래도 확실히 혼자보단 여럿이서 있는데 안심되기는 하니까. 너무 몰려있는건 안좋다고 생각하지만.")
    #                                                                             end
    # test "무료야동보는곳 http://link.com" do
    #                               assert_value KoreanSentenceAnalyser.analyse_sentence("무료야동보는곳 http://link.com")
    #                               end
    # test "RT @user: Rt추첨 한세트) 흑백엑소 판스 일판합니다. 구성 : K28 + M28 + @ =2000원 [흑백엑소/수량/성함/입금예정일] http://link.com" do
    #                                                                                                       assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: Rt추첨 한세트) 흑백엑소 판스 일판합니다. 구성 : K28 + M28 + @ =2000원 [흑백엑소/수량/성함/입금예정일] http://link.com")
    #                                                                                                       end
    # test "@user ㅜㅜㅜ참꺄쨘 키도보고싶다(힑ㅁ" do
    #                              assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅜㅜㅜ참꺄쨘 키도보고싶다(힑ㅁ")
    #                              end
    # test "@user 아 진짜.. 드콘 가고 싶어ㅓㅓㅓ 나 왜 지방..? 내가 이래서 서울 살고 싶다고오융너ㅕㄴ오" do
    #                                                                 assert_value KoreanSentenceAnalyser.analyse_sentence("@user 아 진짜.. 드콘 가고 싶어ㅓㅓㅓ 나 왜 지방..? 내가 이래서 서울 살고 싶다고오융너ㅕㄴ오")
    #                                                                 end
    # test "RT @user: 에릭세트랑 찰스세트 바꾸실 분 안계실까요....ㅠㅠ 찰스ㅠㅠㅠㅠ 찰스ㅠㅠㅠ 에릭세트에 수은이도 들어있어요 ㅠㅜ" do
    #                                                                               assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 에릭세트랑 찰스세트 바꾸실 분 안계실까요....ㅠㅠ 찰스ㅠㅠㅠㅠ 찰스ㅠㅠㅠ 에릭세트에 수은이도 들어있어요 ㅠㅜ")
    #                                                                               end
    # test "@user 나니..가는ㄱㅓ야................?" do
    #                                        assert_value KoreanSentenceAnalyser.analyse_sentence("@user 나니..가는ㄱㅓ야................?")
    #                                        end
    # test "4.여전히좋아햦지온니♥.♥" do
    #                      assert_value KoreanSentenceAnalyser.analyse_sentence("4.여전히좋아햦지온니♥.♥")
    #                      end
    #                      test "@user ㅋㅋㅋㅋㅋㅋㅋㅋㅋ수고하셧어요!!'∨'9" do
    #                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅋㅋㅋㅋㅋㅋㅋㅋㅋ수고하셧어요!!'∨'9")
    #                                                         end
    #                      test "RT @user: 어젯밤 둘이서 말말말 ..^^  http://link.com" do
    #                                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 어젯밤 둘이서 말말말 ..^^  http://link.com")
    #                                                                         end
    #                      test "@user 힘내뢉 ㅠ" do
    #                                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user 힘내뢉 ㅠ")
    #                                         end
    #                      test "정몽준 캠프, 침묵 깬 한마디 "다음에 대통령 하면 되니까" | 미디어다음 http://link.com" do
    #                                                                                       assert_value KoreanSentenceAnalyser.analyse_sentence("정몽준 캠프, 침묵 깬 한마디 "다음에 대통령 하면 되니까" | 미디어다음 http://link.com")
    #                                                                                       end
    #                      test "@user @user @user 아니 일단 걔는 너의 심장을쪼들리게 할수가없는애라 ㅇㅅㅇ..." do
    #                                                                                  assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user @user 아니 일단 걔는 너의 심장을쪼들리게 할수가없는애라 ㅇㅅㅇ...")
    #                                                                                  end
    #                      test "@user 즐거웠습니다. 초반 한수 악수 뒀을 뿐이지 도토링님도 방어하거나 틈새 공격 시도하시는게 엄청나셔요 +_+" do
    #                                                                                              assert_value KoreanSentenceAnalyser.analyse_sentence("@user 즐거웠습니다. 초반 한수 악수 뒀을 뿐이지 도토링님도 방어하거나 틈새 공격 시도하시는게 엄청나셔요 +_+")
    #                                                                                              end
    #                      test "@user (회색멍멍이에게 문의를!)" do
    #                                                  assert_value KoreanSentenceAnalyser.analyse_sentence("@user (회색멍멍이에게 문의를!)")
    #                                                  end
    #                      test "@user 님 헐 ㅓㄹ 아니구나 헐 님 아이패드 삼?" do
    #                                                           assert_value KoreanSentenceAnalyser.analyse_sentence("@user 님 헐 ㅓㄹ 아니구나 헐 님 아이패드 삼?")
    #                                                           end
    #                      test "@user  편집은........어.....어........ 그냥 안하면되(태이언니:뭐래냐)" do
    #                                                                                 assert_value KoreanSentenceAnalyser.analyse_sentence("@user  편집은........어.....어........ 그냥 안하면되(태이언니:뭐래냐)")
    #                                                                                 end
    #                      test "ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ내 룸메 꺼내줘로 설정해놨어" do
    #                                                                          assert_value KoreanSentenceAnalyser.analyse_sentence("ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ내 룸메 꺼내줘로 설정해놨어")
    #                                                                          end
    #                      test "RT @user: 셜록, 그게 사실이야?(옷을 벗는다" do
    #                                                           assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 셜록, 그게 사실이야?(옷을 벗는다")
    #                                                           end
    #                      test "@user 앗 그거 아키하바라에 있어요 정확한 위치는 저도 어딘지 잘 모르겠어서 ㅠㅠㅠ 먼가 맥도날드쪽이었던것같은데 주변건물 이름 기억이 ... orz ... 인터넷에 검색하시면 왠지 나올것같으은 ㅠㅠ .." do
    #                                                                                                                                                 assert_value KoreanSentenceAnalyser.analyse_sentence("@user 앗 그거 아키하바라에 있어요 정확한 위치는 저도 어딘지 잘 모르겠어서 ㅠㅠㅠ 먼가 맥도날드쪽이었던것같은데 주변건물 이름 기억이 ... orz ... 인터넷에 검색하시면 왠지 나올것같으은 ㅠㅠ ..")
    #                                                                                                                                                 end
    #                      test "@user 옹 오키!!8월에달려갈게" do
    #                                                 assert_value KoreanSentenceAnalyser.analyse_sentence("@user 옹 오키!!8월에달려갈게")
    #                                                 end
    #                      test "이따 밤ㅁ에 주작ㄱ님까지 델ㄹ꼬올ㄹ거야 8ㅁ8" do
    #                                                       assert_value KoreanSentenceAnalyser.analyse_sentence("이따 밤ㅁ에 주작ㄱ님까지 델ㄹ꼬올ㄹ거야 8ㅁ8")
    #                                                       end
    #                      test "무료야동보는곳 http://link.com" do
    #                                                     assert_value KoreanSentenceAnalyser.analyse_sentence("무료야동보는곳 http://link.com")
    #                                                     end
    #                      test "@user ^^ㅗ 이거 짱귘ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ" do
    #                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user ^^ㅗ 이거 짱귘ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ")
    #                                                         end
    #                      test "@user 해줄래...?" do
    #                                           assert_value KoreanSentenceAnalyser.analyse_sentence("@user 해줄래...?")
    #                                           end
    #                      test "@user (끄덕거린다.) 근데, 넌 왜 아직 안자냐?" do
    #                                                            assert_value KoreanSentenceAnalyser.analyse_sentence("@user (끄덕거린다.) 근데, 넌 왜 아직 안자냐?")
    #                                                            end
    #                      test "@user [인정좀해요]" do
    #                                           assert_value KoreanSentenceAnalyser.analyse_sentence("@user [인정좀해요]")
    #                                           end
    #                      test "@user 두명이었어^0^..~~~ ㅋㅋㅋㄱㄱㅋㄱㄱㄱㄱㄱㄲ" do
    #                                                              assert_value KoreanSentenceAnalyser.analyse_sentence("@user 두명이었어^0^..~~~ ㅋㅋㅋㄱㄱㅋㄱㄱㄱㄱㄱㄲ")
    #                                                              end
    #                      test "@user 오빠는요?밥절대거루지말고꼬박꼬박챙겨먹어요!!♥" do
    #                                                             assert_value KoreanSentenceAnalyser.analyse_sentence("@user 오빠는요?밥절대거루지말고꼬박꼬박챙겨먹어요!!♥")
    #                                                             end
    #                      test "@user 툽님... 쩌 쩐다..." do
    #                                                 assert_value KoreanSentenceAnalyser.analyse_sentence("@user 툽님... 쩌 쩐다...")
    #                                                 end
    #                      test "@user `ㄴㅇㄹㅁ;ㅐㄹㅁ;ㅈㄷㄹ미ㅏㅈㄷ리ㅏ먿ㅈ러;ㅁ지ㅏㄹㅁ;ㅣㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ" do
    #                                                                                                                                                                       assert_value KoreanSentenceAnalyser.analyse_sentence("@user `ㄴㅇㄹㅁ;ㅐㄹㅁ;ㅈㄷㄹ미ㅏㅈㄷ리ㅏ먿ㅈ러;ㅁ지ㅏㄹㅁ;ㅣㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ")
    #                                                                                                                                                                       end
    #                      test "내가 당신에게 대체 무슨 잘못을 했다고 나를 증오하나요. 대체 왜! 나는 당신을 몰라요, 그런 눈으로 나를 바라보지 마요, 제발, 너무 고통스러워요... 제발..." do
    #                                                                                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("내가 당신에게 대체 무슨 잘못을 했다고 나를 증오하나요. 대체 왜! 나는 당신을 몰라요, 그런 눈으로 나를 바라보지 마요, 제발, 너무 고통스러워요... 제발...")
    #                                                                                                                         end
    #                      test "푸산.. 인천... 흑...." do
    #                                              assert_value KoreanSentenceAnalyser.analyse_sentence("푸산.. 인천... 흑....")
    #                                              end
    #                      test "잠ㅋ깐 http://link.com" do
    #                                                 assert_value KoreanSentenceAnalyser.analyse_sentence("잠ㅋ깐 http://link.com")
    #                                                 end
    #                      test "@user 사실 대- 충 때워버렸지." do
    #                                                  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 사실 대- 충 때워버렸지.")
    #                                                  end
    #                      test "@user 다음팬싸는 서면중교복입을까요 ㅋㅋㅋㅋㅋㅋㅋㅋㅋ? http://link.com" do
    #                                                                              assert_value KoreanSentenceAnalyser.analyse_sentence("@user 다음팬싸는 서면중교복입을까요 ㅋㅋㅋㅋㅋㅋㅋㅋㅋ? http://link.com")
    #                                                                              end
    #                      test "본인이 싸인까지 하고 투표확인증은 카드 전표처럼." do
    #                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("본인이 싸인까지 하고 투표확인증은 카드 전표처럼.")
    #                                                         end
    #                      test "@user 쯔레기에요...ㅠㅠㅠㅠㅠㅠㅠㅠ" do
    #                                                    assert_value KoreanSentenceAnalyser.analyse_sentence("@user 쯔레기에요...ㅠㅠㅠㅠㅠㅠㅠㅠ")
    #                                                    end
    #                      test "RT @user: Minwoo has opened his twitter acct &amp; released his photo "@user: 매번 단체트위터하다가" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: Minwoo has opened his twitter acct &amp; released his photo "@user: 매번 단체트위터하다가")
    #                                                                                                                                                      end
    #                                                                                                                                                      test "145. 한국민속촌 트위터와 대검찰청 트위터가 드립으로 유명세를 떨쳤는데, 누군가가 이 둘을 커플로 엮은 팬아트가 등장했는데, 일이 커져서 마침내 출판사에서 지원해 이 둘이 웹툰으로 태어났다. 웹툰 링크는 http://link.com" do
    #                                                                                                                                                                                                                                                                                                assert_value KoreanSentenceAnalyser.analyse_sentence("145. 한국민속촌 트위터와 대검찰청 트위터가 드립으로 유명세를 떨쳤는데, 누군가가 이 둘을 커플로 엮은 팬아트가 등장했는데, 일이 커져서 마침내 출판사에서 지원해 이 둘이 웹툰으로 태어났다. 웹툰 링크는 http://link.com")
    #                                                                                                                                                                                                                                                                                                end
    #                      test "사요나라아이와코코마데닷따코코로모야시아이시따코노히비와부키요스기타오와리닷따카나시이에이가오미테따키가시타 잘가요ㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠ" do
    #                                                                                                  assert_value KoreanSentenceAnalyser.analyse_sentence("사요나라아이와코코마데닷따코코로모야시아이시따코노히비와부키요스기타오와리닷따카나시이에이가오미테따키가시타 잘가요ㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠ")
    #                                                                                                  end
    #                      test "@user 별루..? http://link.com" do
    #                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user 별루..? http://link.com")
    #                                                         end
    #                      test "@user 언니 나 잠깐 다른쪽 갔다올게요 @user@!!!!!!!!!!!!!" do
    #                                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user 언니 나 잠깐 다른쪽 갔다올게요 @user@!!!!!!!!!!!!!")
    #                                                                         end
    #                      test "@user 러시안룰렛하면서 이것저것 했으면 좋겠쟈" do
    #                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user 러시안룰렛하면서 이것저것 했으면 좋겠쟈")
    #                                                         end
    #                      test "@user 나 어데 멘션 지웠능데 다시해줘.." do
    #                                                       assert_value KoreanSentenceAnalyser.analyse_sentence("@user 나 어데 멘션 지웠능데 다시해줘..")
    #                                                       end
    #                      test "@user @user 앜ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ 제 메일주소는 mel...." do
    #                                                                                    assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user 앜ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ 제 메일주소는 mel....")
    #                                                                                    end
    #                      test "@user ㄱ그래...그리고 무한반복ㄱ되는 일상...(아련" do
    #                                                              assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㄱ그래...그리고 무한반복ㄱ되는 일상...(아련")
    #                                                              end
    #                      test "@user 딜체님이 트레해오시려나보다" do
    #                                                  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 딜체님이 트레해오시려나보다")
    #                                                  end
    #                      test "@user 호....... 로롤ㄹㄹㄹㄹㄹㄹ 진짜 그거예요......? 진짜...??? 왜 쓰는 거지ㅣ 그러면...??? 개가 짖는다 같은 느낌정도의 표현인가..??? (마리님:그게 왜 궁금한데..." do
    #                                                                                                                                            assert_value KoreanSentenceAnalyser.analyse_sentence("@user 호....... 로롤ㄹㄹㄹㄹㄹㄹ 진짜 그거예요......? 진짜...??? 왜 쓰는 거지ㅣ 그러면...??? 개가 짖는다 같은 느낌정도의 표현인가..??? (마리님:그게 왜 궁금한데...")
    #                                                                                                                                            end
    #                      test "…… (나무에 원고지를 걸어놓고 있다.)" do
    #                                                    assert_value KoreanSentenceAnalyser.analyse_sentence("…… (나무에 원고지를 걸어놓고 있다.)")
    #                                                    end
    #                      test "@user 캠프에 전화해볼텨;?" do
    #                                               assert_value KoreanSentenceAnalyser.analyse_sentence("@user 캠프에 전화해볼텨;?")
    #                                               end
    #                      test "@user 파랑새가 먹었네요8ㅁ8" do
    #                                                assert_value KoreanSentenceAnalyser.analyse_sentence("@user 파랑새가 먹었네요8ㅁ8")
    #                                                end
    #                      test "으헤헤 라니 시발 선생님 ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ" do
    #                                                                  assert_value KoreanSentenceAnalyser.analyse_sentence("으헤헤 라니 시발 선생님 ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ")
    #                                                                  end
    #                      test "꺼내줘 카톡알람 어디가면 받을수잇어요.....?" do
    #                                                        assert_value KoreanSentenceAnalyser.analyse_sentence("꺼내줘 카톡알람 어디가면 받을수잇어요.....?")
    #                                                        end
    #                      test "RT @user: 이제 곧 '현충일' 국립묘지 돌보는 공군장병: 공군 중앙전산소 장병 120여 명이 3일 국립 대전현충원 묘역에서 태극기 교체 봉사를 하고 있다. 이날 장병들은 비가오는 중에도 현충원 참배와 태극기 ... http://link.com…" do
    #                                                                                                                                                                          assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 이제 곧 '현충일' 국립묘지 돌보는 공군장병: 공군 중앙전산소 장병 120여 명이 3일 국립 대전현충원 묘역에서 태극기 교체 봉사를 하고 있다. 이날 장병들은 비가오는 중에도 현충원 참배와 태극기 ... http://link.com…")
    #                                                                                                                                                                          end
    #                      test "@user 여름방학중 언젠가ㅎ....여......" do
    #                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user 여름방학중 언젠가ㅎ....여......")
    #                                                         end
    # test "투표율을 높이고 대한민국의 미래를 위해서. http://link.com" do
    #                                               assert_value KoreanSentenceAnalyser.analyse_sentence("투표율을 높이고 대한민국의 미래를 위해서. http://link.com")
    #                                               end
    # test "에....뭐랄까... 한심하네요, 주인님. http://link.com" do
    #                                               assert_value KoreanSentenceAnalyser.analyse_sentence("에....뭐랄까... 한심하네요, 주인님. http://link.com")
    #                                               end
    # test "@user 응. 잘 부탁해요. :)" do
    #                           assert_value KoreanSentenceAnalyser.analyse_sentence("@user 응. 잘 부탁해요. :)")
    #                           end
    # test "@user *｡٩(ˊωˋ*)و*｡ 제가 한 귀여움 합니다." do
    #                                        assert_value KoreanSentenceAnalyser.analyse_sentence("@user *｡٩(ˊωˋ*)و*｡ 제가 한 귀여움 합니다.")
    #                                        end
    # test "Facebook에 새 사진을 게시했습니다 http://link.com" do
    #                                              assert_value KoreanSentenceAnalyser.analyse_sentence("Facebook에 새 사진을 게시했습니다 http://link.com")
    #                                              end
    # test "@user 아시는군요! ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ" do
    #                                                                  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 아시는군요! ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ")
    #                                                                  end
    # test "@user 좋은 밤 되세요 오빵~~" do
    #                           assert_value KoreanSentenceAnalyser.analyse_sentence("@user 좋은 밤 되세요 오빵~~")
    #                           end
    # test "라그나는 뉴와 하나가 될 거야. 영원히 함께 할 거야..." do
    #                                        assert_value KoreanSentenceAnalyser.analyse_sentence("라그나는 뉴와 하나가 될 거야. 영원히 함께 할 거야...")
    #                                        end
    # test "이거바.....전원코드나 잭이나 둘중 하나가 맛탱이가 간거같다니까 왜 직원은 아니라고 해서...이거바 이거바 아 (짲응" do
    #                                                                          assert_value KoreanSentenceAnalyser.analyse_sentence("이거바.....전원코드나 잭이나 둘중 하나가 맛탱이가 간거같다니까 왜 직원은 아니라고 해서...이거바 이거바 아 (짲응")
    #                                                                          end
    # test "@user 돔은... 주인... 펨은 여자... 멜은 남자..." do
    #                                           assert_value KoreanSentenceAnalyser.analyse_sentence("@user 돔은... 주인... 펨은 여자... 멜은 남자...")
    #                                           end
    # test "&lt;치킨2014&gt; 득표현황" do
    #                           assert_value KoreanSentenceAnalyser.analyse_sentence("&lt;치킨2014&gt; 득표현황")
    #                           end
    # test "요즈음 제가 성숙해지고 있다는 느낌을 받습니다." do
    #                                  assert_value KoreanSentenceAnalyser.analyse_sentence("요즈음 제가 성숙해지고 있다는 느낌을 받습니다.")
    #                                  end
    # test "언니가 문 두드려도 나오지도 않고 엑스레이 안찍어봤으면서 11만원 받아내고 ... 치노 데리고 더 큰 병원에 가서 인큐베이터에서 회복중임" do
    #                                                                                    assert_value KoreanSentenceAnalyser.analyse_sentence("언니가 문 두드려도 나오지도 않고 엑스레이 안찍어봤으면서 11만원 받아내고 ... 치노 데리고 더 큰 병원에 가서 인큐베이터에서 회복중임")
    #                                                                                    end
    # test "???근데 그걸 성적으로 좋아한다는것만 말하는거야???" do
    #                                      assert_value KoreanSentenceAnalyser.analyse_sentence("???근데 그걸 성적으로 좋아한다는것만 말하는거야???")
    #                                      end
    # test "@user ⊙⊙!!!♥(꼬옥" do
    #                       assert_value KoreanSentenceAnalyser.analyse_sentence("@user ⊙⊙!!!♥(꼬옥")
    #                       end
    # test "[트윗중독검사] "문자보다 멘션에 답장을 빨리함" (rank=5.5%) http://link.com" do
    #                                                               assert_value KoreanSentenceAnalyser.analyse_sentence("[트윗중독검사] "문자보다 멘션에 답장을 빨리함" (rank=5.5%) http://link.com")
    #                                                               end
    # test ""@user: 140604 Kiss the radio SG says he hits the members cheeks to wake them up when they get drunk #인피니트" ㅎㅎ" do
    #                                                                               assert_value KoreanSentenceAnalyser.analyse_sentence(""@user: 140604 Kiss the radio SG says he hits the members cheeks to wake them up when they get drunk #인피니트" ㅎㅎ")
    #                                                                                                                                                                                                         end
    #                                                                                                                                                                                                         test "RT @user: 140604 쇼챔~♡ Show champion @user #강인 #Kangin http://link.com" do
    #                                                                                                                                                                                                                                                                                      assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 140604 쇼챔~♡ Show champion @user #강인 #Kangin http://link.com")
    #                                                                                                                                                                                                                                                                                      end
    #                                                                                                                                                                                                              test "친구가 화장시켜줬는데 어색해....ㅋㅋㅋㅋㅋㅋ 화장 안해봐서" do
    #                                                                                                                                                                                                                                                       assert_value KoreanSentenceAnalyser.analyse_sentence("친구가 화장시켜줬는데 어색해....ㅋㅋㅋㅋㅋㅋ 화장 안해봐서")
    #                                                                                                                                                                                                                                                       end
    #                                                                                                                                                                                                              test "말자님 신작...신작하시는거야...." do
    #                                                                                                                                                                                                                                          assert_value KoreanSentenceAnalyser.analyse_sentence("말자님 신작...신작하시는거야....")
    #                                                                                                                                                                                                                                          end
    #                                                                                                                                                                                                              test "RT @user: @user @user 또 눈물이 나는군요. 정부는 하루 빨리 구하라. 무능한 작자들아. 구조라도 잘해야지. 잘하는게 없는 무책임한 정부. 우린 누굴 믿고 사나." do
    #                                                                                                                                                                                                                                                                                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: @user @user 또 눈물이 나는군요. 정부는 하루 빨리 구하라. 무능한 작자들아. 구조라도 잘해야지. 잘하는게 없는 무책임한 정부. 우린 누굴 믿고 사나.")
    #                                                                                                                                                                                                                                                                                                                         end
    #                                                                                                                                                                                                              test "@user 정빈조도 http://link.com" do
    #                                                                                                                                                                                                                                                assert_value KoreanSentenceAnalyser.analyse_sentence("@user 정빈조도 http://link.com")
    #                                                                                                                                                                                                                                                end
    # test "@user .... 아니..... 탐라에 보이...길ㄹ....래......" do
    #                                                 assert_value KoreanSentenceAnalyser.analyse_sentence("@user .... 아니..... 탐라에 보이...길ㄹ....래......")
    #                                                 end
    # test "[트위터운세] 오늘은 프로텍트를 걸어야 할 운세입니다. http://link.com" do
    #                                                      assert_value KoreanSentenceAnalyser.analyse_sentence("[트위터운세] 오늘은 프로텍트를 걸어야 할 운세입니다. http://link.com")
    #                                                      end
    # test "@user 아아... 소원빌어." do
    #                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user 아아... 소원빌어.")
    #                         end
    # test "@user 그분도 긔여움 맨션하시는게 ㅋㅋ" do
    #                               assert_value KoreanSentenceAnalyser.analyse_sentence("@user 그분도 긔여움 맨션하시는게 ㅋㅋ")
    #                               end
    # test "@user 저 세훈있는데 종인이랑 교환하실래요?" do
    #                                  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 저 세훈있는데 종인이랑 교환하실래요?")
    #                                  end
    # test "@user 엉?! 만두도 이렇게 쌈싸먹는거양?! 신기방기~!" do
    #                                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user 엉?! 만두도 이렇게 쌈싸먹는거양?! 신기방기~!")
    #                                         end
    # test "Facebook에 새 사진을 게시했습니다 http://link.com" do
    #                                              assert_value KoreanSentenceAnalyser.analyse_sentence("Facebook에 새 사진을 게시했습니다 http://link.com")
    #                                              end
    # test "전효성 – Good-night Kiss http://link.com" do
    #                                             assert_value KoreanSentenceAnalyser.analyse_sentence("전효성 – Good-night Kiss http://link.com")
    #                                             end
    # test "투표하러 가야한다..=-=" do
    #                      assert_value KoreanSentenceAnalyser.analyse_sentence("투표하러 가야한다..=-=")
    #                      end
    # test "@user 잘자아........" do
    #                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user 잘자아........")
    #                         end
    # test "맞아 오늘 우는여자 부채를 노나주길래 주워왔다" do
    #                                 assert_value KoreanSentenceAnalyser.analyse_sentence("맞아 오늘 우는여자 부채를 노나주길래 주워왔다")
    #                                 end
    # test "@user ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ연새님 기여웤ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ" do
    #                                                                                                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ연새님 기여웤ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ")
    #                                                                                                                                         end
    # test "@user 안녕해유. 잠자유? 왜 벌써자유????" do
    #                                   assert_value KoreanSentenceAnalyser.analyse_sentence("@user 안녕해유. 잠자유? 왜 벌써자유????")
    #                                   end
    # test "@user 혼 레기가 전해달래 ㅋㅋ (혼 존트 싫어) #joke" do
    #                                           assert_value KoreanSentenceAnalyser.analyse_sentence("@user 혼 레기가 전해달래 ㅋㅋ (혼 존트 싫어) #joke")
    #                                           end
    # test "@user 스엉엉엉 은하수님ㅜㅠㅠㅜ 감사해요♥♥" do
    #                                  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 스엉엉엉 은하수님ㅜㅠㅠㅜ 감사해요♥♥")
    #                                  end
    # test "@user 저4퍼라구...이제 봤는데" do
    #                            assert_value KoreanSentenceAnalyser.analyse_sentence("@user 저4퍼라구...이제 봤는데")
    #                            end
    # test "@user 검찰 PI 니들 정체가 뭐야" do
    #                             assert_value KoreanSentenceAnalyser.analyse_sentence("@user 검찰 PI 니들 정체가 뭐야")
    #                             end
    # test "@user 이럴때만 하는 사랑 필요없어유ㅇㅅㅇ" do
    #                                 assert_value KoreanSentenceAnalyser.analyse_sentence("@user 이럴때만 하는 사랑 필요없어유ㅇㅅㅇ")
    #                                 end
    # test "엑소 맏형들의 위엄.. (일반인주의) http://link.com" do
    #                                            assert_value KoreanSentenceAnalyser.analyse_sentence("엑소 맏형들의 위엄.. (일반인주의) http://link.com")
    #                                            end
    # test "@user 저런...시끄러운건 좋지않아." do
    #                              assert_value KoreanSentenceAnalyser.analyse_sentence("@user 저런...시끄러운건 좋지않아.")
    #                              end
    # test "@user 고2에여~ :3" do
    #                      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 고2에여~ :3")
    #                      end
    # test "@user 시스믹은 귀여운 피터로 나오니까 걱정말라눈!!" do
    #                                       assert_value KoreanSentenceAnalyser.analyse_sentence("@user 시스믹은 귀여운 피터로 나오니까 걱정말라눈!!")
    #                                       end
    # test "@user ㄴㄴ 프로모션이랑 막 해축 정보 이런거 다 차단중 개꿀" do
    #                                            assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㄴㄴ 프로모션이랑 막 해축 정보 이런거 다 차단중 개꿀")
    #                                            end
    # test "@user ㅋㅋㅋㅋㅋㅋ" do
    #                    assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅋㅋㅋㅋㅋㅋ")
    #                    end
    # test "@user 청춘ㄴ쨩 허벅지도 부들부들" do
    #                            assert_value KoreanSentenceAnalyser.analyse_sentence("@user 청춘ㄴ쨩 허벅지도 부들부들")
    #                            end
    # test "@user อาร์ตมากค่ะ ㅋㅋㅋㅋㅋㅋ" do
    #                                assert_value KoreanSentenceAnalyser.analyse_sentence("@user อาร์ตมากค่ะ ㅋㅋㅋㅋㅋㅋ")
    #                                end
    # test "RT @user: 저도 아까 아침에 아무거나 막 트윗하다가 반성하고 지금 신중히 리튓중이예여 RT @user: 간간히 정말 함정 튓이 있다" do
    #                                                                                     assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 저도 아까 아침에 아무거나 막 트윗하다가 반성하고 지금 신중히 리튓중이예여 RT @user: 간간히 정말 함정 튓이 있다")
    #                                                                                     end
    # test "&lt;워싱턴의 韓日…이번엔 '싱크탱크 전쟁'&gt; http://link.com" do
    #                                                     assert_value KoreanSentenceAnalyser.analyse_sentence("&lt;워싱턴의 韓日…이번엔 '싱크탱크 전쟁'&gt; http://link.com")
    #                                                     end
    # test "@user 신부감 아이다 8//8)" do
    #                           assert_value KoreanSentenceAnalyser.analyse_sentence("@user 신부감 아이다 8//8)")
    #                           end
    # test "@user ㅋㅋㅋㅋ진심ㅋㅋㅋ경기도지사부터 교육ㄱ감 시장까지ㅋㅋㅋㅋ첫투표부터이렇게깜깜합니다" do
    #                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅋㅋㅋㅋ진심ㅋㅋㅋ경기도지사부터 교육ㄱ감 시장까지ㅋㅋㅋㅋ첫투표부터이렇게깜깜합니다")
    #                                                         end
    # test "@user 뭐야 그게-! 030" do
    #                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user 뭐야 그게-! 030")
    #                         end
    # test "@user 지금 트위터를 하고있다는 이유는 지금 일어낫다" do
    #                                       assert_value KoreanSentenceAnalyser.analyse_sentence("@user 지금 트위터를 하고있다는 이유는 지금 일어낫다")
    #                                       end
    # test "@user 쭈니님ㅁ때문도 있ㅅ고 여러가지로 내사람ㅁ들 때문에 계속 심쿵ㅇ함다 쿵 쿵" do
    #                                                      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 쭈니님ㅁ때문도 있ㅅ고 여러가지로 내사람ㅁ들 때문에 계속 심쿵ㅇ함다 쿵 쿵")
    #                                                      end
    # test "@user 집 넓히는게 힘들지만ㅂㄷㅂㄷ..." do
    #                                assert_value KoreanSentenceAnalyser.analyse_sentence("@user 집 넓히는게 힘들지만ㅂㄷㅂㄷ...")
    #                                end
    # test "@user 잘됬네 곧 갈꺼지? 나도 같이 가자고. 계속 방에만 있어서 길도 헷갈리고 해서말이야" do
    #                                                            assert_value KoreanSentenceAnalyser.analyse_sentence("@user 잘됬네 곧 갈꺼지? 나도 같이 가자고. 계속 방에만 있어서 길도 헷갈리고 해서말이야")
    #                                                            end
    # test "어떻게 올릉보다 못할수 있죠 ; 어휴" do
    #                            assert_value KoreanSentenceAnalyser.analyse_sentence("어떻게 올릉보다 못할수 있죠 ; 어휴")
    #                            end
    # test "@user ㅋㅋ 알겟오요" do
    #                     assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅋㅋ 알겟오요")
    #                     end
    # test "RT @user: [큰일이다 변호사 지망생 언니가 역전재판 시작했어ㅓㅓㅓ][이쪽이 더 큰일이야 우리 오빠는 음대 가려 하는데 보컬로이드 알아버렸다ㅏㅏㅏ][뭐 그정도 가지고 우리 삼촌은 문명 시작했단 말이야ㅏㅏㅏ] 어느  놈도 다 큰일이다" do
    #                                                                                                                                            assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: [큰일이다 변호사 지망생 언니가 역전재판 시작했어ㅓㅓㅓ][이쪽이 더 큰일이야 우리 오빠는 음대 가려 하는데 보컬로이드 알아버렸다ㅏㅏㅏ][뭐 그정도 가지고 우리 삼촌은 문명 시작했단 말이야ㅏㅏㅏ] 어느  놈도 다 큰일이다")
    #                                                                                                                                            end
    # test "@user 허억...르네...르네야...ㅠㅠㅠㅠㅠㅠㅠ사...사탕쥴까..???" do
    #                                                  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 허억...르네...르네야...ㅠㅠㅠㅠㅠㅠㅠ사...사탕쥴까..???")
    #                                                  end
    # test "3. 자캐였을 땐 상당한 S였다고 합니다....()" do
    #                                    assert_value KoreanSentenceAnalyser.analyse_sentence("3. 자캐였을 땐 상당한 S였다고 합니다....()")
    #                                    end
    # test "@user 미쳤나봐요... 왤케 귀엽지... 아.. 쿸님부터 전 이미 저세상이었는데 으아으앙으아" do
    #                                                             assert_value KoreanSentenceAnalyser.analyse_sentence("@user 미쳤나봐요... 왤케 귀엽지... 아.. 쿸님부터 전 이미 저세상이었는데 으아으앙으아")
    #                                                             end
    # test "@user 맞팔부탁드려요.." do
    #                       assert_value KoreanSentenceAnalyser.analyse_sentence("@user 맞팔부탁드려요..")
    #                       end
    # test "RT @user: 하라부지가 뭐 뚜시뚜시 뜨르른!! 쾅쾅 퍼엉 히는 영화를 봉다. 울 할부지는 블록버슷허 조아해 응응" do
    #                                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 하라부지가 뭐 뚜시뚜시 뜨르른!! 쾅쾅 퍼엉 히는 영화를 봉다. 울 할부지는 블록버슷허 조아해 응응")
    #                                                                         end
    # test "@user @user @user ㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎ 제가 과학자라면 태닝을 돌려놓는 기계를 만들거임" do
    #                                                                 assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user @user ㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎ 제가 과학자라면 태닝을 돌려놓는 기계를 만들거임")
    #                                                                 end
    # test "@user ...내가 그냥 인간한테 당할 것 같냐." do
    #                                    assert_value KoreanSentenceAnalyser.analyse_sentence("@user ...내가 그냥 인간한테 당할 것 같냐.")
    #                                    end
    # test "@user ㅋㅋㅋㅋㅋㅋㅋㅋㅋ 공유도 있더라. ㅎㅅㅎ. http://link.com" do
    #                                                     assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅋㅋㅋㅋㅋㅋㅋㅋㅋ 공유도 있더라. ㅎㅅㅎ. http://link.com")
    #                                                     end
    # test "@user 울 주영이 다른 애들 보는데선 쑥쓰러운고야?" do
    #                                      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 울 주영이 다른 애들 보는데선 쑥쓰러운고야?")
    #                                      end
    # test "@user 헛...시른데...;*;" do
    #                           assert_value KoreanSentenceAnalyser.analyse_sentence("@user 헛...시른데...;*;")
    #                           end
    # test "이러다가 레어템 꿈이 아델 말빨로 이기는 걸지도...." do
    #                                      assert_value KoreanSentenceAnalyser.analyse_sentence("이러다가 레어템 꿈이 아델 말빨로 이기는 걸지도....")
    #                                      end
    # test "@user 저도 잘 몰겠어여 어케 그렇게 히면 된다던데ㅠㅠ" do
    #                                        assert_value KoreanSentenceAnalyser.analyse_sentence("@user 저도 잘 몰겠어여 어케 그렇게 히면 된다던데ㅠㅠ")
    #                                        end
    # test "@user  우아ㅓㅜㅏㅓㅓ ㅠㅠㅠ 오팔님 운다 쉽팜 폰에 저런 멋진 집사님을 왜 만든거에여!!!!/주먹울음" do
    #                                                                   assert_value KoreanSentenceAnalyser.analyse_sentence("@user  우아ㅓㅜㅏㅓㅓ ㅠㅠㅠ 오팔님 운다 쉽팜 폰에 저런 멋진 집사님을 왜 만든거에여!!!!/주먹울음")
    #                                                                   end
    # test "잠깐만 이거 나 사약......안되요 죽기 싫어요 읍컥" do
    #                                      assert_value KoreanSentenceAnalyser.analyse_sentence("잠깐만 이거 나 사약......안되요 죽기 싫어요 읍컥")
    #                                      end
    # test "그렇게 당했으면서 여전한 저 맹목적인 지지율은...참" do
    #                                     assert_value KoreanSentenceAnalyser.analyse_sentence("그렇게 당했으면서 여전한 저 맹목적인 지지율은...참")
    #                                     end
    # test "@user 우워어어럵 팬싸 가고시퐁...★" do
    #                               assert_value KoreanSentenceAnalyser.analyse_sentence("@user 우워어어럵 팬싸 가고시퐁...★")
    #                               end
    # test "@user 씨빌!!!!!!!!!!님 들음??문제 의학용어로 낸다던데 뭔말인지는 몰겠는데 걍 예를들면 오름대동먁을 오름대동맥이라는 한글말고 ㅋAscending aorta 이렇게쓰실곤가봄 시바라라라라라라" do
    #                                                                                                                       assert_value KoreanSentenceAnalyser.analyse_sentence("@user 씨빌!!!!!!!!!!님 들음??문제 의학용어로 낸다던데 뭔말인지는 몰겠는데 걍 예를들면 오름대동먁을 오름대동맥이라는 한글말고 ㅋAscending aorta 이렇게쓰실곤가봄 시바라라라라라라")
    #                                                                                                                       end
    # test "RT @user: 더 이상 다이어트로 고민할 필요 없을 듯~ http://link.com (..)" do
    #                                                              assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 더 이상 다이어트로 고민할 필요 없을 듯~ http://link.com (..)")
    #                                                              end
    # test "@user 으..응..." do
    #                     assert_value KoreanSentenceAnalyser.analyse_sentence("@user 으..응...")
    #                     end
    # test "@user 머..ㅜ머야....아닐ㄹ꺼야....아니겠지... 저 얼굴에 나랑 똑같은 사진이 나올줄ㄹ이야..." do
    #                                                                   assert_value KoreanSentenceAnalyser.analyse_sentence("@user 머..ㅜ머야....아닐ㄹ꺼야....아니겠지... 저 얼굴에 나랑 똑같은 사진이 나올줄ㄹ이야...")
    #                                                                   end
    # test "@user ...글쎄.(으쓱)" do
    #                        assert_value KoreanSentenceAnalyser.analyse_sentence("@user ...글쎄.(으쓱)")
    #                        end
    # test "내일만 가면 이번주 평일은 끝나는것이다  ᕕ( ᐛ )ᕗ 어예에" do
    #                                          assert_value KoreanSentenceAnalyser.analyse_sentence("내일만 가면 이번주 평일은 끝나는것이다  ᕕ( ᐛ )ᕗ 어예에")
    #                                          end
    # test "@user 이그....(아련)" do
    #                        assert_value KoreanSentenceAnalyser.analyse_sentence("@user 이그....(아련)")
    #                        end
    # test "어쩌지 예상외로 너무다르다... http://link.com" do
    #                                         assert_value KoreanSentenceAnalyser.analyse_sentence("어쩌지 예상외로 너무다르다... http://link.com")
    #                                         end
    # test "@user ㅋㅋ큐ㅠㅠㅠ 뭐죠 이 도장 마법의 도장인가 ㅎㅎ 투표인증하고싶엇는뒈ㅠㅠ" do
    #                                                     assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅋㅋ큐ㅠㅠㅠ 뭐죠 이 도장 마법의 도장인가 ㅎㅎ 투표인증하고싶엇는뒈ㅠㅠ")
    #                                                     end
    # test "@user 앗 부농색이라니...! 조은걸...! ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ 뭐먹고크나요..?" do
    #                                                           assert_value KoreanSentenceAnalyser.analyse_sentence("@user 앗 부농색이라니...! 조은걸...! ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ 뭐먹고크나요..?")
    #                                                           end
    # test "우왕 당첨됏당!!!!ㅇㅁㅇ*" do
    #                       assert_value KoreanSentenceAnalyser.analyse_sentence("우왕 당첨됏당!!!!ㅇㅁㅇ*")
    #                       end
    # test "대선때도 그랬고 지방선거도 그렇고 주위에 1번 찍었다는 사람들은 아무도 없는데 1번이 왜 되는거얔ㅋㅋㅋㅋㅋ 대체 누가 찍는거얔ㅋㅋㅋㅋㅋ 아 궁그맼ㅋㅋㅋㅋ" do
    #                                                                                             assert_value KoreanSentenceAnalyser.analyse_sentence("대선때도 그랬고 지방선거도 그렇고 주위에 1번 찍었다는 사람들은 아무도 없는데 1번이 왜 되는거얔ㅋㅋㅋㅋㅋ 대체 누가 찍는거얔ㅋㅋㅋㅋㅋ 아 궁그맼ㅋㅋㅋㅋ")
    #                                                                                             end
    # test "피터 거미남인데 독은없나??피터가 다른사람 앙 하고 물면 그사람은 거미남 안되나?" do
    #                                                     assert_value KoreanSentenceAnalyser.analyse_sentence("피터 거미남인데 독은없나??피터가 다른사람 앙 하고 물면 그사람은 거미남 안되나?")
    #                                                     end
    # test "하....미끼유천 부럽다.....ㅠㅠ 시아준수 맨투맨 라이브공연을 ㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠ" do
    #                                                          assert_value KoreanSentenceAnalyser.analyse_sentence("하....미끼유천 부럽다.....ㅠㅠ 시아준수 맨투맨 라이브공연을 ㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠ")
    #                                                          end
    # test "2. 버카랑 지갑 놓고 와서 다시 집올라옴" do
    #                               assert_value KoreanSentenceAnalyser.analyse_sentence("2. 버카랑 지갑 놓고 와서 다시 집올라옴")
    #                               end
    # test "@user  미미요ㅠㅠㅜ미나!!" do
    #                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user  미미요ㅠㅠㅜ미나!!")
    #                         end
    # test "3. 첫인상 →기억력병신...." do
    #                         assert_value KoreanSentenceAnalyser.analyse_sentence("3. 첫인상 →기억력병신....")
    #                         end
    # test "@user  귀여운 화원님이 귀엽다고해주셨어..!°*:. (*´艸｀) :*.° 화원님사전에 똥낙서같은건 없숴여ㅠㅠㅜㅠㅠ화원님이 발가락으로 그리셔도 그건 아트가되고ㅠㅠㅠ(화원님:뭐라는거야;;;;;" do
    #                                                                                                                    assert_value KoreanSentenceAnalyser.analyse_sentence("@user  귀여운 화원님이 귀엽다고해주셨어..!°*:. (*´艸｀) :*.° 화원님사전에 똥낙서같은건 없숴여ㅠㅠㅜㅠㅠ화원님이 발가락으로 그리셔도 그건 아트가되고ㅠㅠㅠ(화원님:뭐라는거야;;;;;")
    #                                                                                                                    end
    # test "@user 키킬 나는 선거 결과 보려고 잠깐 깼다 이제 절망하며 다시 자야지.." do
    #                                                    assert_value KoreanSentenceAnalyser.analyse_sentence("@user 키킬 나는 선거 결과 보려고 잠깐 깼다 이제 절망하며 다시 자야지..")
    #                                                    end
    # test "@user @user  시벌 반응 봐ㄱㄱㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ" do
    #                                        assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user  시벌 반응 봐ㄱㄱㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ")
    #                                        end
    # test "저는 910의 식량을 수확했어요! http://link.com #android, #androidgames, #gameinsight" do
    #                                                                                assert_value KoreanSentenceAnalyser.analyse_sentence("저는 910의 식량을 수확했어요! http://link.com #android, #androidgames, #gameinsight")
    #                                                                                end
    # test "@user 어라, 내가 너같은 애한테 예의를 갖춰줘야 하는 거야?" do
    #                                            assert_value KoreanSentenceAnalyser.analyse_sentence("@user 어라, 내가 너같은 애한테 예의를 갖춰줘야 하는 거야?")
    #                                            end
    # test "@user 오빠 끝난거에요??ㅠㅠ 제발ㅠㅠ 투표인증할게요!!! 칭찬해주세요!!!! 컴백이 얼마 안남았어요! 항상 응원하고 있으니 오빠도 힘내요!!!!^^ 나의 하트를 받아라☞☞☞☞☞☞☞☞♥ http://link.com" do
    #                                                                                                                                 assert_value KoreanSentenceAnalyser.analyse_sentence("@user 오빠 끝난거에요??ㅠㅠ 제발ㅠㅠ 투표인증할게요!!! 칭찬해주세요!!!! 컴백이 얼마 안남았어요! 항상 응원하고 있으니 오빠도 힘내요!!!!^^ 나의 하트를 받아라☞☞☞☞☞☞☞☞♥ http://link.com")
    #                                                                                                                                 end
    # test "싫은게 아니라 무서운건데 정말 무서워서 가끔 나 막 입은 웃는데 눈물 뚝뚝 흘리면서 트위터하는데" do
    #                                                             assert_value KoreanSentenceAnalyser.analyse_sentence("싫은게 아니라 무서운건데 정말 무서워서 가끔 나 막 입은 웃는데 눈물 뚝뚝 흘리면서 트위터하는데")
    #                                                             end
    # test "출구조사 결과 다들 보셨지요? 그럼 수원역으로 고고씽 하시면 됩니다. 7시 30분 촛불추모제 합니다. 출구조사 결과 수원역이 썰렁하다는 예측입니다!" do
    #                                                                                          assert_value KoreanSentenceAnalyser.analyse_sentence("출구조사 결과 다들 보셨지요? 그럼 수원역으로 고고씽 하시면 됩니다. 7시 30분 촛불추모제 합니다. 출구조사 결과 수원역이 썰렁하다는 예측입니다!")
    #                                                                                          end
    # test ""악마"는 인간의 혼을 먹는다.하지만 "악마"는 실체를 가질 수 없고 인간을 직접 죽일수 없다."마녀"는 "악마"에게 혼을 바친다.그 댓가로 "악마"는 "마녀"에게 마법을 부여한다."악마"와 계약을 맺은 인간을 "마녀"라고 부른다 #Bot" do
    #                                                                                                                                             assert_value KoreanSentenceAnalyser.analyse_sentence(""악마"는 인간의 혼을 먹는다.하지만 "악마"는 실체를 가질 수 없고 인간을 직접 죽일수 없다."마녀"는 "악마"에게 혼을 바친다.그 댓가로 "악마"는 "마녀"에게 마법을 부여한다."악마"와 계약을 맺은 인간을 "마녀"라고 부른다 #Bot")
    #                                                                                                                                             end
    #                                                                   test "@user ㅜ난지금상황이말이아니다... 꼭ㄱ꿀빨고오세용ㅇ💕💕" do
    #                                                                                                              assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅜ난지금상황이말이아니다... 꼭ㄱ꿀빨고오세용ㅇ💕💕")
    #                                                                                                              end
    #                                                                   test "@user @user ㅜㅜ 아녜여ㅜㅜ 메구언니한테 뱃지 같이 넘겨드렸어용!ㅁ!ㅎㅎ" do
    #                                                                                                                        assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user ㅜㅜ 아녜여ㅜㅜ 메구언니한테 뱃지 같이 넘겨드렸어용!ㅁ!ㅎㅎ")
    #                                                                                                                        end
    #                                                                   test "RT @user: 아무튼 나 같으면 기립도 하고 악수에 응했을 텐데... 하는 생각이 듬 ㅇㅇ 자연인은 싫을 수 있지만 우리가 그 제도와 상징을 혐오하는 건 아니쟈나이까?" do
    #                                                                                                                                                                          assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 아무튼 나 같으면 기립도 하고 악수에 응했을 텐데... 하는 생각이 듬 ㅇㅇ 자연인은 싫을 수 있지만 우리가 그 제도와 상징을 혐오하는 건 아니쟈나이까?")
    #                                                                                                                                                                          end
    # test "RT @user: 나츠 「화장실가고싶어어~」" do
    #                                assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 나츠 「화장실가고싶어어~」")
    #                                end
    # test "호텔 왔어요~ http://link.com" do
    #                               assert_value KoreanSentenceAnalyser.analyse_sentence("호텔 왔어요~ http://link.com")
    #                               end
    # test "@user 마크제이콥스 좋은거 있던데요 언니! 검은 리본 달린 향수.." do
    #                                               assert_value KoreanSentenceAnalyser.analyse_sentence("@user 마크제이콥스 좋은거 있던데요 언니! 검은 리본 달린 향수..")
    #                                               end
    # test "@user 안피곤해?ㅠㅠ" do
    #                     assert_value KoreanSentenceAnalyser.analyse_sentence("@user 안피곤해?ㅠㅠ")
    #                     end
    # test "@user 지금 집에 들어가는 중." do
    #                           assert_value KoreanSentenceAnalyser.analyse_sentence("@user 지금 집에 들어가는 중.")
    #                           end
    # test "@user 낮잠은 30분이 가장 적당하다고 들었거든요~" do
    #                                      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 낮잠은 30분이 가장 적당하다고 들었거든요~")
    #                                      end
    # test "adult [어덜트]어른의, 성인의, 어른스러운." do
    #                                   assert_value KoreanSentenceAnalyser.analyse_sentence("adult [어덜트]어른의, 성인의, 어른스러운.")
    #                                   end
    # test "@user ㅇ엩ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ!! 어케나욌는데여..!" do
    #                                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅇ엩ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ!! 어케나욌는데여..!")
    #                                         end
    # test "친구(프랑스인.남)한테 양해구하고 빨리찍느라 흔들렸..8ㅁ8 #와인 #치즈 #햄 #소세지 #빵 #먹고죽자 http://link.com" do
    #                                                                                  assert_value KoreanSentenceAnalyser.analyse_sentence("친구(프랑스인.남)한테 양해구하고 빨리찍느라 흔들렸..8ㅁ8 #와인 #치즈 #햄 #소세지 #빵 #먹고죽자 http://link.com")
    #                                                                                  end
    # test "@user ........ 왜 이렇게 집요해." do
    #                                 assert_value KoreanSentenceAnalyser.analyse_sentence("@user ........ 왜 이렇게 집요해.")
    #                                 end
    # test "@user 아하.. 근데 개전이 생각보다 쉽게 나왔네요" do
    #                                      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 아하.. 근데 개전이 생각보다 쉽게 나왔네요")
    #                                      end
    # test "@user 홀 여기 어댜??? 대박" do
    #                           assert_value KoreanSentenceAnalyser.analyse_sentence("@user 홀 여기 어댜??? 대박")
    #                           end
    # test "친구들은 괜찮다 하는데 오히려 우리집은 부모님이 더 뭐라하시는구나ㅏ 하하ㅏ" do
    #                                                 assert_value KoreanSentenceAnalyser.analyse_sentence("친구들은 괜찮다 하는데 오히려 우리집은 부모님이 더 뭐라하시는구나ㅏ 하하ㅏ")
    #                                                 end
    # test "@user 저두궁금해여ㅠ!" do
    #                      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 저두궁금해여ㅠ!")
    #                      end
    # test "집에 가면 손톱을 다듬고. 해가 지면 운동을. 하거나. 술을 마셔야겠다. - 술. 어디에 있는 무슨 모텔 몇호실. 각자 마실 술 준비 요망. 안주는 주최자가 준비함." do
    #                                                                                                    assert_value KoreanSentenceAnalyser.analyse_sentence("집에 가면 손톱을 다듬고. 해가 지면 운동을. 하거나. 술을 마셔야겠다. - 술. 어디에 있는 무슨 모텔 몇호실. 각자 마실 술 준비 요망. 안주는 주최자가 준비함.")
    #                                                                                                    end
    # test "@user 아............ 아이라인도 껴주세요.... 빼노ㅎ을수없어...." do
    #                                                      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 아............ 아이라인도 껴주세요.... 빼노ㅎ을수없어....")
    #                                                      end
    # test "RT @user: 뒷차가 들이박았을때 http://link.com" do
    #                                            assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 뒷차가 들이박았을때 http://link.com")
    #                                            end
    # test "문체가 맘에안들어 넘 딱딱하고 재미없어" do
    #                             assert_value KoreanSentenceAnalyser.analyse_sentence("문체가 맘에안들어 넘 딱딱하고 재미없어")
    #                             end
    # test "목동 야구장, 내겐 신천지 같은 세상 http://link.com 출처 : 네이버 카페" do
    #                                                        assert_value KoreanSentenceAnalyser.analyse_sentence("목동 야구장, 내겐 신천지 같은 세상 http://link.com 출처 : 네이버 카페")
    #                                                        end
    # test "@user 맞찌?♡" do
    #                  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 맞찌?♡")
    #                  end
    # test "@user 거미!!!!!" do
    #                     assert_value KoreanSentenceAnalyser.analyse_sentence("@user 거미!!!!!")
    #                     end
    # test "아 존나뻘쭘함..관리아저씨 밖에다 나 내버랴두고감...." do
    #                                       assert_value KoreanSentenceAnalyser.analyse_sentence("아 존나뻘쭘함..관리아저씨 밖에다 나 내버랴두고감....")
    #                                       end
    # test "1. 교육감은 진보교육감 압승" do
    #                        assert_value KoreanSentenceAnalyser.analyse_sentence("1. 교육감은 진보교육감 압승")
    #                        end
    # test "임재범이 박진영에게 [하고싶어..]라고 문자하자 몇시간후에 [지ㅣ그ㅁ금갉꼐 ㅇ기달ㄹ러!!]라고 답장옵니다. http://link.com" do
    #                                                                                   assert_value KoreanSentenceAnalyser.analyse_sentence("임재범이 박진영에게 [하고싶어..]라고 문자하자 몇시간후에 [지ㅣ그ㅁ금갉꼐 ㅇ기달ㄹ러!!]라고 답장옵니다. http://link.com")
    #                                                                                   end
    # test "@user 내 트친중에 화성시인트친 있는데!아닌가??" do
    #                                     assert_value KoreanSentenceAnalyser.analyse_sentence("@user 내 트친중에 화성시인트친 있는데!아닌가??")
    #                                     end
    # test "@user it's more just when you open the door to go out...basically it's just really bad that's all (ㅠ_ㅠ)" do
    #                                                                                                               assert_value KoreanSentenceAnalyser.analyse_sentence("@user it's more just when you open the door to go out...basically it's just really bad that's all (ㅠ_ㅠ)")
    #                                                                                                               end
    # test "@user 누나일본이벤트즐거웠어..보고싶어누나~~ http://link.com" do
    #                                                   assert_value KoreanSentenceAnalyser.analyse_sentence("@user 누나일본이벤트즐거웠어..보고싶어누나~~ http://link.com")
    #                                                   end
    # test "@user 아니 안펴요....얌삐님 꼬시려고 구라쳐봣어..." do
    #                                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user 아니 안펴요....얌삐님 꼬시려고 구라쳐봣어...")
    #                                         end
    # test "「어린시절에 츠보미쨩은 정말 귀여웠는데말이야, 예전에는 말이지, 내가 세상에서 제일 좋다고 했었 …」" do
    #                                                                assert_value KoreanSentenceAnalyser.analyse_sentence("「어린시절에 츠보미쨩은 정말 귀여웠는데말이야, 예전에는 말이지, 내가 세상에서 제일 좋다고 했었 …」")
    #                                                                end
    # test "6월 3일 최악. 바보같은 하루. 그래서 올리는 성공하기 위한 방법 http://link.com" do
    #                                                             assert_value KoreanSentenceAnalyser.analyse_sentence("6월 3일 최악. 바보같은 하루. 그래서 올리는 성공하기 위한 방법 http://link.com")
    #                                                             end
    # test "@user 나, 나를 위한…?" do
    #                        assert_value KoreanSentenceAnalyser.analyse_sentence("@user 나, 나를 위한…?")
    #                        end
    # test "[스타뷰티쇼] 페이스인페이스 클렌징워터/트룰리워터리 클렌징워터 사용후기 http://link.com" do
    #                                                               assert_value KoreanSentenceAnalyser.analyse_sentence("[스타뷰티쇼] 페이스인페이스 클렌징워터/트룰리워터리 클렌징워터 사용후기 http://link.com")
    #                                                               end
    # test "토가미... 토가미군 나 토가미군에게 잘보이려고 공부도 열심히 할거라구요... 쓰레기같은 성적표를 토가미군한테 어떻게 보여줘..." do
    #                                                                                assert_value KoreanSentenceAnalyser.analyse_sentence("토가미... 토가미군 나 토가미군에게 잘보이려고 공부도 열심히 할거라구요... 쓰레기같은 성적표를 토가미군한테 어떻게 보여줘...")
    #                                                                                end
    # test "@user 밷상사... 우리 자기 힘들게 하지말라 ㅜㅜ" do
    #                                      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 밷상사... 우리 자기 힘들게 하지말라 ㅜㅜ")
    #                                      end
    # test "RT @user: 이 꼴통을 우쨔지? http://link.com" do
    #                                            assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 이 꼴통을 우쨔지? http://link.com")
    #                                            end
    # test "@user 회기 오실래여 여기 버거킹 있어요" do
    #                                assert_value KoreanSentenceAnalyser.analyse_sentence("@user 회기 오실래여 여기 버거킹 있어요")
    #                                end
    # test "[동아일보] 이적 투표 독려 “투표하기 딱 좋은 날씨” http://link.com #동아일보" do
    #                                                            assert_value KoreanSentenceAnalyser.analyse_sentence("[동아일보] 이적 투표 독려 “투표하기 딱 좋은 날씨” http://link.com #동아일보")
    #                                                            end
    # test "무료야동보는곳 http://link.com" do
    #                               assert_value KoreanSentenceAnalyser.analyse_sentence("무료야동보는곳 http://link.com")
    #                               end
    # test "@user ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ" do
    #                             assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ")
    #                             end
    # test "@user ㅜㅜㅜ 너 토욜에 시간있남?" do
    #                             assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅜㅜㅜ 너 토욜에 시간있남?")
    #                             end
    # test "@user 워매 깜짝이야" do
    #                     assert_value KoreanSentenceAnalyser.analyse_sentence("@user 워매 깜짝이야")
    #                     end
    # test "@user 아닙니다,괜찮아요. 약 찾았거든요." do
    #                                 assert_value KoreanSentenceAnalyser.analyse_sentence("@user 아닙니다,괜찮아요. 약 찾았거든요.")
    #                                 end
    # test "아!!!!경남 ㅠ.ㅠ" do
    #                   assert_value KoreanSentenceAnalyser.analyse_sentence("아!!!!경남 ㅠ.ㅠ")
    #                   end
    # test "RT @user: @user 해금 조건인 Quietus Ray보다 더 쉽다?!? 빛이 되라라는 의미의 라틴어에서 온 제목!" do
    #                                                                            assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: @user 해금 조건인 Quietus Ray보다 더 쉽다?!? 빛이 되라라는 의미의 라틴어에서 온 제목!")
    #                                                                            end
    # test "@user 아니야~ 11시27분만 고픈 거야~~" do
    #                                  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 아니야~ 11시27분만 고픈 거야~~")
    #                                  end
    # test "한 시다, 설마 지금까지 안 자는건 아니겠지?" do
    #                                 assert_value KoreanSentenceAnalyser.analyse_sentence("한 시다, 설마 지금까지 안 자는건 아니겠지?")
    #                                 end
    # test "큐ㅠㅠㅠ4명가면 랍스타 준다니 ㅠㅠ뀨ㅠㅠㅠ" do
    #                               assert_value KoreanSentenceAnalyser.analyse_sentence("큐ㅠㅠㅠ4명가면 랍스타 준다니 ㅠㅠ뀨ㅠㅠㅠ")
    #                               end
    # test "@user ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ" do
    #                          assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ")
    #                          end
    # test "@user 그 말도 들었어." do
    #                       assert_value KoreanSentenceAnalyser.analyse_sentence("@user 그 말도 들었어.")
    #                       end
    # test "쪽쪽쪽!! 맛있다구요!" do
    #                    assert_value KoreanSentenceAnalyser.analyse_sentence("쪽쪽쪽!! 맛있다구요!")
    #                    end
    # test "@user ( . .) 그래여! 믿어줄게여!" do
    #                                assert_value KoreanSentenceAnalyser.analyse_sentence("@user ( . .) 그래여! 믿어줄게여!")
    #                                end
    # test "6 shades of LJH’s adorableness ㅜㅜ http://link.com" do
    #                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("6 shades of LJH’s adorableness ㅜㅜ http://link.com")
    #                                                         end
    # test "@user 겅부..해야져ㅜㅜㅡㅜㅡㅜ" do
    #                           assert_value KoreanSentenceAnalyser.analyse_sentence("@user 겅부..해야져ㅜㅜㅡㅜㅡㅜ")
    #                           end
    # test "@user 이건가 http://link.com" do
    #                                 assert_value KoreanSentenceAnalyser.analyse_sentence("@user 이건가 http://link.com")
    #                                 end
    # test "@user 날 따른 개민가?" do
    #                       assert_value KoreanSentenceAnalyser.analyse_sentence("@user 날 따른 개민가?")
    #                       end
    # test "서초,강남,송파,중랑,중구 만 새누리당 소속의원 유력한 상태...." do
    #                                             assert_value KoreanSentenceAnalyser.analyse_sentence("서초,강남,송파,중랑,중구 만 새누리당 소속의원 유력한 상태....")
    #                                             end
    # test "이모가... 내가 사랑해마지 않는 이모가... (통곡" do
    #                                     assert_value KoreanSentenceAnalyser.analyse_sentence("이모가... 내가 사랑해마지 않는 이모가... (통곡")
    #                                     end
    # test "9시 18분 현재 수성구와 달서구는 김부겸이 앞서고 있음." do
    #                                        assert_value KoreanSentenceAnalyser.analyse_sentence("9시 18분 현재 수성구와 달서구는 김부겸이 앞서고 있음.")
    #                                        end
    # test "@user :0 무지 많다..." do
    #                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user :0 무지 많다...")
    #                         end
    # test "@user ㅇㅇ그러셈" do
    #                   assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅇㅇ그러셈")
    #                   end
    # test "@user 히에에ㅔㅔ 차별(, ," do
    #                          assert_value KoreanSentenceAnalyser.analyse_sentence("@user 히에에ㅔㅔ 차별(, ,")
    #                          end
    # test "@user ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ쟤 공주병ㅇ이야... 예쁘다고하면 소녀도 압니다 다른 말없습니까? 이러는...(사가지)" do
    #                                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ쟤 공주병ㅇ이야... 예쁘다고하면 소녀도 압니다 다른 말없습니까? 이러는...(사가지)")
    #                                                                         end
    # test "@user '됨/됌', '된/됀' 이들 중에 뭐가 맞아요?" do
    #                                        assert_value KoreanSentenceAnalyser.analyse_sentence("@user '됨/됌', '된/됀' 이들 중에 뭐가 맞아요?")
    #                                        end
    # test "@user 부러운년......" do
    #                        assert_value KoreanSentenceAnalyser.analyse_sentence("@user 부러운년......")
    #                        end
    # test "@user 오구오구 그랬냐 삐치기전이라서 다행이네" do
    #                                   assert_value KoreanSentenceAnalyser.analyse_sentence("@user 오구오구 그랬냐 삐치기전이라서 다행이네")
    #                                   end
    # test "@user 순진한 척 하기는. 다 벗고 있으란 말 꺼낸건 오빱니다, 응?" do
    #                                                assert_value KoreanSentenceAnalyser.analyse_sentence("@user 순진한 척 하기는. 다 벗고 있으란 말 꺼낸건 오빱니다, 응?")
    #                                                end
    # test "@user 앗~ 합정 바보주막 예약했는데~" do
    #                               assert_value KoreanSentenceAnalyser.analyse_sentence("@user 앗~ 합정 바보주막 예약했는데~")
    #                               end
    # test "@user 나도 수업들이 좀 편한거면 자체휴강하겠는뎈ㅋㅋ큐ㅠㅠ" do
    #                                          assert_value KoreanSentenceAnalyser.analyse_sentence("@user 나도 수업들이 좀 편한거면 자체휴강하겠는뎈ㅋㅋ큐ㅠㅠ")
    #                                          end
    # test "RT @user: 아무리 저열한 흑색선전을 해도 선거 후에는 덮어 주는 걸 승자의 아량이자 패자의 미덕으로 취급하는 문화, 참 오래됐습니다. 하지만 국정원의 저질 댓글 공작은 이런 문화에 기생했습니다. 승패를 떠나, 흑색선전을 단죄하는 문화…" do
    #                                                                                                                                               assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 아무리 저열한 흑색선전을 해도 선거 후에는 덮어 주는 걸 승자의 아량이자 패자의 미덕으로 취급하는 문화, 참 오래됐습니다. 하지만 국정원의 저질 댓글 공작은 이런 문화에 기생했습니다. 승패를 떠나, 흑색선전을 단죄하는 문화…")
    #                                                                                                                                               end
    # test "@user 애기잖냐 너" do
    #                    assert_value KoreanSentenceAnalyser.analyse_sentence("@user 애기잖냐 너")
    #                    end
    # test "@user 근데 잔디노 진쟈 후쿠신이랑 비쥬얼 비슷한 거 가태!ㅋㅋㅋㅋㅋ또 머 좋아했지....음 마자 란치무쿠랑 감마백란도 좋아했어여(씹사약)ㅋㅋㅋㅋㅋㅋ" do
    #                                                                                             assert_value KoreanSentenceAnalyser.analyse_sentence("@user 근데 잔디노 진쟈 후쿠신이랑 비쥬얼 비슷한 거 가태!ㅋㅋㅋㅋㅋ또 머 좋아했지....음 마자 란치무쿠랑 감마백란도 좋아했어여(씹사약)ㅋㅋㅋㅋㅋㅋ")
    #                                                                                             end
    # test "@user 음.. 알았어요 누나." do
    #                          assert_value KoreanSentenceAnalyser.analyse_sentence("@user 음.. 알았어요 누나.")
    #                          end
    # test "논님 http://link.com" do
    #                          assert_value KoreanSentenceAnalyser.analyse_sentence("논님 http://link.com")
    #                          end
    # test "@user 한참... 전에.." do
    #                        assert_value KoreanSentenceAnalyser.analyse_sentence("@user 한참... 전에..")
    #                        end
    # test "@user 난 지갑이 두개가있는줄알았다.." do
    #                               assert_value KoreanSentenceAnalyser.analyse_sentence("@user 난 지갑이 두개가있는줄알았다..")
    #                               end
    # test "@user 재밌었겠네 체육대회. 그래,가끔 쉬는 날도 필요하지." do
    #                                           assert_value KoreanSentenceAnalyser.analyse_sentence("@user 재밌었겠네 체육대회. 그래,가끔 쉬는 날도 필요하지.")
    #                                           end
    # test "@user 흐엨ㅋㅋㅋ도우시떼!" do
    #                        assert_value KoreanSentenceAnalyser.analyse_sentence("@user 흐엨ㅋㅋㅋ도우시떼!")
    #                        end
    # test "결국 관계 쫑나고(여자애가 먼저 선을 그었을 거 같음) 학교로 돌아와서도 한동안은 좀 침울해했을 거 같음..졸업 후 링컨은 아주 극단적인 길을 갈 거 같다 아예 마법사들 속에서 살거나 아님 머글들 속에서 살거나..는 또 나이들면서 변하겠지.." do
    #                                                                                                                                               assert_value KoreanSentenceAnalyser.analyse_sentence("결국 관계 쫑나고(여자애가 먼저 선을 그었을 거 같음) 학교로 돌아와서도 한동안은 좀 침울해했을 거 같음..졸업 후 링컨은 아주 극단적인 길을 갈 거 같다 아예 마법사들 속에서 살거나 아님 머글들 속에서 살거나..는 또 나이들면서 변하겠지..")
    #                                                                                                                                               end
    # test "엄마는 집에있는데 내가투표하러안가녰더니 뭐라뭐라하길래 좀다툼...아빠는 가게일때문에ㅜㅜ 일찍나가서...언니는 외국에있어서 못하고.." do
    #                                                                                 assert_value KoreanSentenceAnalyser.analyse_sentence("엄마는 집에있는데 내가투표하러안가녰더니 뭐라뭐라하길래 좀다툼...아빠는 가게일때문에ㅜㅜ 일찍나가서...언니는 외국에있어서 못하고..")
    #                                                                                 end
    # test "@user 222222222짤줍때문에 스트레스 오만상 받음" do
    #                                        assert_value KoreanSentenceAnalyser.analyse_sentence("@user 222222222짤줍때문에 스트레스 오만상 받음")
    #                                        end
    # test "@user 엇,그럼 좀 위험한거네??..음..알겠어!죽지않을정도의 양만 줘도되니깐?(손내밀어" do
    #                                                           assert_value KoreanSentenceAnalyser.analyse_sentence("@user 엇,그럼 좀 위험한거네??..음..알겠어!죽지않을정도의 양만 줘도되니깐?(손내밀어")
    #                                                           end
    # test "@user 흥 ㅇㅁㅇ! 잠자는 맹수라구~~~~~~~!!" do
    #                                      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 흥 ㅇㅁㅇ! 잠자는 맹수라구~~~~~~~!!")
    #                                      end
    # test "아직 찾아줘야 할 기억들이 수두룩한데..(인형은 머리를 긁으며 전사들을 쳐다보았다.)" do
    #                                                       assert_value KoreanSentenceAnalyser.analyse_sentence("아직 찾아줘야 할 기억들이 수두룩한데..(인형은 머리를 긁으며 전사들을 쳐다보았다.)")
    #                                                       end
    # test "와... 나지금 손그림 색칠하는구나..." do
    #                              assert_value KoreanSentenceAnalyser.analyse_sentence("와... 나지금 손그림 색칠하는구나...")
    #                              end
    # test "책펴고 데구르르..바람은 솔솔.." do
    #                          assert_value KoreanSentenceAnalyser.analyse_sentence("책펴고 데구르르..바람은 솔솔..")
    #                          end
    # test "4. 지금인상 → 존예 매력 팡팡 쿨!" do
    #                             assert_value KoreanSentenceAnalyser.analyse_sentence("4. 지금인상 → 존예 매력 팡팡 쿨!")
    #                             end
    # test "인장용으로 그린 판토무........ 히히 좋아 귀여워 () http://link.com" do
    #                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("인장용으로 그린 판토무........ 히히 좋아 귀여워 () http://link.com")
    #                                                         end
    # test "@user 줄려면 우리 만나야징ㅜㅜ 언제 보나요?" do
    #                                   assert_value KoreanSentenceAnalyser.analyse_sentence("@user 줄려면 우리 만나야징ㅜㅜ 언제 보나요?")
    #                                   end
    # test "@user @user 민석인...?" do
    #                           assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user 민석인...?")
    #                           end
    # test "@user 야. 이제야 스페이디다." do
    #                           assert_value KoreanSentenceAnalyser.analyse_sentence("@user 야. 이제야 스페이디다.")
    #                           end
    # test "@user 그렇게하지. #미소" do
    #                        assert_value KoreanSentenceAnalyser.analyse_sentence("@user 그렇게하지. #미소")
    #                        end
    # test "주위보단..상대가 저를 싫어할 것이라는 점..심리적인 거부요.솔직히 지금 반대할 사람은 딱히 없는데 . .있다해도 오빠정도,.. ." do
    #                                                                                 assert_value KoreanSentenceAnalyser.analyse_sentence("주위보단..상대가 저를 싫어할 것이라는 점..심리적인 거부요.솔직히 지금 반대할 사람은 딱히 없는데 . .있다해도 오빠정도,.. .")
    #                                                                                 end
    # test "@user ★병크는 초반에 족칩시다★" do
    #                            assert_value KoreanSentenceAnalyser.analyse_sentence("@user ★병크는 초반에 족칩시다★")
    #                            end
    # test "@user 단거 좋아해요?" do
    #                      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 단거 좋아해요?")
    #                      end
    # test "@user 저 피로에 떨어서 잠들고 지금 인나써여.. ㅇ&lt;-&lt;" do
    #                                                assert_value KoreanSentenceAnalyser.analyse_sentence("@user 저 피로에 떨어서 잠들고 지금 인나써여.. ㅇ&lt;-&lt;")
    #                                                end
    # test "오늘은 #Happy6002day ♥️#HappyBirthday #생일 #축하해요 ♥️ #6002 #6002theMicky #박유천 #유천 #yuchun #JYJ #Love… http://link.com" do
    #                                                                                                                        assert_value KoreanSentenceAnalyser.analyse_sentence("오늘은 #Happy6002day ♥️#HappyBirthday #생일 #축하해요 ♥️ #6002 #6002theMicky #박유천 #유천 #yuchun #JYJ #Love… http://link.com")
    #                                                                                                                        end
    # test "@user 이런말 잘 안하는데 몸매하난 개 끝난다 진짜.." do
    #                                        assert_value KoreanSentenceAnalyser.analyse_sentence("@user 이런말 잘 안하는데 몸매하난 개 끝난다 진짜..")
    #                                        end
    # test "@user 에이 뭐 그거 가지고.. (다시 옆구리에 부빗) 포근해서 좋은데 뭐..." do
    #                                                      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 에이 뭐 그거 가지고.. (다시 옆구리에 부빗) 포근해서 좋은데 뭐...")
    #                                                      end
    # test "MBC 트페입갤ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ" do
    #                                        assert_value KoreanSentenceAnalyser.analyse_sentence("MBC 트페입갤ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ")
    #                                        end
    # test "민메이의 노랫소리와 함께 커피의 향이 남는 1시 30분." do
    #                                       assert_value KoreanSentenceAnalyser.analyse_sentence("민메이의 노랫소리와 함께 커피의 향이 남는 1시 30분.")
    #                                       end
    # test "@user 하~~~ㄷㄷ" do
    #                    assert_value KoreanSentenceAnalyser.analyse_sentence("@user 하~~~ㄷㄷ")
    #                    end
    # test "@user ㅎㅎ.ㅎ...존ㄴ좋ㅎ...자고일어나서 기분 개 째졋는데 ㅎㅎㅎㅎㅎㅎㅎㅎㅎ(드러눕는다" do
    #                                                            assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅎㅎ.ㅎ...존ㄴ좋ㅎ...자고일어나서 기분 개 째졋는데 ㅎㅎㅎㅎㅎㅎㅎㅎㅎ(드러눕는다")
    #                                                            end
    # test "@user 아이 뭘 그런걸 다" do
    #                        assert_value KoreanSentenceAnalyser.analyse_sentence("@user 아이 뭘 그런걸 다")
    #                        end
    # test "@user 이상한사람이라뇨 죽고싶습니까 소피님" do
    #                                 assert_value KoreanSentenceAnalyser.analyse_sentence("@user 이상한사람이라뇨 죽고싶습니까 소피님")
    #                                 end
    # test "문 너머의 목소리는 더는, 들리지 않아." do
    #                              assert_value KoreanSentenceAnalyser.analyse_sentence("문 너머의 목소리는 더는, 들리지 않아.")
    #                              end
    # test "@user @user 어디서 개수작" do
    #                           assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user 어디서 개수작")
    #                           end
    # test "서울에 비해 확실히 싸다. 오.사.카. 물가가 싼 게 아니라 서울 물가가 너무 비싼 거라 생각" do
    #                                                            assert_value KoreanSentenceAnalyser.analyse_sentence("서울에 비해 확실히 싸다. 오.사.카. 물가가 싼 게 아니라 서울 물가가 너무 비싼 거라 생각")
    #                                                            end
    # test "@user ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ친창좀ㅋㅋㅋㅋㅋㅋㅋ자비좀ㅋㅋㅋㅋㅋㅋ" do
    #                                                           assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ친창좀ㅋㅋㅋㅋㅋㅋㅋ자비좀ㅋㅋㅋㅋㅋㅋ")
    #                                                           end
    # test "@user 폐하 귀여웤ㅋㅋ" do
    #                      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 폐하 귀여웤ㅋㅋ")
    #                      end
    # test "고런처 쓰다가-&gt;도돌 쓰다가-&gt; 버즈로 갈아탔다가-&gt; 걍 다시 도돌로 돌아옴" do
    #                                                           assert_value KoreanSentenceAnalyser.analyse_sentence("고런처 쓰다가-&gt;도돌 쓰다가-&gt; 버즈로 갈아탔다가-&gt; 걍 다시 도돌로 돌아옴")
    #                                                           end
    # test "지금볼땐 어릴 때의 감정이 우정에 가깝다고 볼 수 있을 것 같다. 기억으론 발랄하고 예쁜 아이, 나랑 키가 비슷했지만 까불어서 종종 나한테 맞았던 아이, 흰 피부에 마르고 커서 교복이 잘 어울렸지만 첫번째 아이를 괴롭히면 내가 응징하러 뛰어다닌 아이," do
    #                                                                                                                                                    assert_value KoreanSentenceAnalyser.analyse_sentence("지금볼땐 어릴 때의 감정이 우정에 가깝다고 볼 수 있을 것 같다. 기억으론 발랄하고 예쁜 아이, 나랑 키가 비슷했지만 까불어서 종종 나한테 맞았던 아이, 흰 피부에 마르고 커서 교복이 잘 어울렸지만 첫번째 아이를 괴롭히면 내가 응징하러 뛰어다닌 아이,")
    #                                                                                                                                                    end
    # test "기술가정시간 숙제가 시험범위 내에서 문제 만들어오기였는데 그게 존나 귀찮았던 나는" do
    #                                                     assert_value KoreanSentenceAnalyser.analyse_sentence("기술가정시간 숙제가 시험범위 내에서 문제 만들어오기였는데 그게 존나 귀찮았던 나는")
    #                                                     end
    # test "아저씨 왔는데.흠...앞으로 잘 부탁해.저녁은 먹었어?쉬는날이 훌쩍 가버린것같아서 좀 서운하네-(두 손에는 이삿짐이 잔뜩 들려진채로 집으로 들어선다.마지막 짐인듯 싶다)" do
    #                                                                                                      assert_value KoreanSentenceAnalyser.analyse_sentence("아저씨 왔는데.흠...앞으로 잘 부탁해.저녁은 먹었어?쉬는날이 훌쩍 가버린것같아서 좀 서운하네-(두 손에는 이삿짐이 잔뜩 들려진채로 집으로 들어선다.마지막 짐인듯 싶다)")
    #                                                                                                      end
    # test "@user 왜 다들 '집사'라 스스로를 칭하시는지 알겠다는요;;;" do
    #                                            assert_value KoreanSentenceAnalyser.analyse_sentence("@user 왜 다들 '집사'라 스스로를 칭하시는지 알겠다는요;;;")
    #                                            end
    # test "@user 아, 정의당.. ㅠㅠ" do
    #                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user 아, 정의당.. ㅠㅠ")
    #                         end
    # test "@user 전부터 알긴 알았는데 새삼 서로 이해하긴 너무 늦은 걸 깨달으면 또 와장창되는 것 같다 으으 여튼 감사합니다 오늘은 일찍 자야지.." do
    #                                                                                       assert_value KoreanSentenceAnalyser.analyse_sentence("@user 전부터 알긴 알았는데 새삼 서로 이해하긴 너무 늦은 걸 깨달으면 또 와장창되는 것 같다 으으 여튼 감사합니다 오늘은 일찍 자야지..")
    #                                                                                       end
    # test "@user 뭘 이런 걸 갖고 감사하다고 그러냐. (싱겁다는 듯이 픽 웃으며 빵 봉지 하나를 깐다) 마지막 날까지 계속 매점에서 때워야하려나~" do
    #                                                                                      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 뭘 이런 걸 갖고 감사하다고 그러냐. (싱겁다는 듯이 픽 웃으며 빵 봉지 하나를 깐다) 마지막 날까지 계속 매점에서 때워야하려나~")
    #                                                                                      end
    # test "웅탐 은미사라 홍마이클 진아나레. 이조합도짱재밌게보고 기프티콘받은걸로 라떼 마시면서 종로를 향해 걷는중~^^ 웅탐도 넘 좋아서 기분 좋게 랄랄라~ㅎ http://link.com" do
    #                                                                                                          assert_value KoreanSentenceAnalyser.analyse_sentence("웅탐 은미사라 홍마이클 진아나레. 이조합도짱재밌게보고 기프티콘받은걸로 라떼 마시면서 종로를 향해 걷는중~^^ 웅탐도 넘 좋아서 기분 좋게 랄랄라~ㅎ http://link.com")
    #                                                                                                          end
    # test "@user ((((앗시미춘 왜;;;;;ㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠ))))" do
    #                                                      assert_value KoreanSentenceAnalyser.analyse_sentence("@user ((((앗시미춘 왜;;;;;ㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠ))))")
    #                                                      end
    # test "@user 선풍기 사망설 ㅋㅋㅋㅋㅋㅋㅋㅋㅋ" do
    #                               assert_value KoreanSentenceAnalyser.analyse_sentence("@user 선풍기 사망설 ㅋㅋㅋㅋㅋㅋㅋㅋㅋ")
    #                               end
    # test "하필 재생되는 노래제목도 아저씨.......존중입니다 취향해주세요 아저씨 존좋" do
    #                                                   assert_value KoreanSentenceAnalyser.analyse_sentence("하필 재생되는 노래제목도 아저씨.......존중입니다 취향해주세요 아저씨 존좋")
    #                                                   end
    # test "지켜 보고 계시지요? 우리 어떻게 해볼께요. 걱정 마세요. http://link.com" do
    #                                                        assert_value KoreanSentenceAnalyser.analyse_sentence("지켜 보고 계시지요? 우리 어떻게 해볼께요. 걱정 마세요. http://link.com")
    #                                                        end
    # test "RT @user: @user 오늘그린이건 좀 나은듯... http://link.com" do
    #                                                       assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: @user 오늘그린이건 좀 나은듯... http://link.com")
    #                                                       end
    # test "@user @user 아니 200명있는 커뮤에서도 하는데... 총괄 부총괄 총 세명이라 안카셨나.." do
    #                                                               assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user 아니 200명있는 커뮤에서도 하는데... 총괄 부총괄 총 세명이라 안카셨나..")
    #                                                               end
    # test "แซ่บมาก!!!!!!!!! “Comecloser24: 140604 빅스 레오 staff 콘서트 http://link.com”" do
    #                                                                               assert_value KoreanSentenceAnalyser.analyse_sentence("แซ่บมาก!!!!!!!!! “Comecloser24: 140604 빅스 레오 staff 콘서트 http://link.com”")
    #                                                                               end
    # test "RT @user: @user 공개 결혼식해야죠 ^오^" do
    #                                     assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: @user 공개 결혼식해야죠 ^오^")
    #                                     end
    # test "@user 지금 쥬리나가 나온 방송 보고 있는데 거기서 올바른 양치질에대해서 나오고 있거든요 ㅋㅋ 거기서 그러더라구요 ㄷㄷㄷㄷ" do
    #                                                                              assert_value KoreanSentenceAnalyser.analyse_sentence("@user 지금 쥬리나가 나온 방송 보고 있는데 거기서 올바른 양치질에대해서 나오고 있거든요 ㅋㅋ 거기서 그러더라구요 ㄷㄷㄷㄷ")
    #                                                                              end
    # test "@user 그렇다고 적립된게 지워지지도 않아^^" do
    #                                  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 그렇다고 적립된게 지워지지도 않아^^")
    #                                  end
    # test "@user ..? 초콜렛 술?" do
    #                        assert_value KoreanSentenceAnalyser.analyse_sentence("@user ..? 초콜렛 술?")
    #                        end
    # test "@user 먼가변심같다 변심.. 변태심..?" do
    #                                assert_value KoreanSentenceAnalyser.analyse_sentence("@user 먼가변심같다 변심.. 변태심..?")
    #                                end
    # test "'뿌요승부'를 통해 당신이 정말 '왕자' 인지를 증" do
    #                                    assert_value KoreanSentenceAnalyser.analyse_sentence("'뿌요승부'를 통해 당신이 정말 '왕자' 인지를 증")
    #                                    end
    #                                    test ""@user: 우는남자 동건형님 퐈이팅 !!^^ http://link.com"" do
    #                                                                                       assert_value KoreanSentenceAnalyser.analyse_sentence(""@user: 우는남자 동건형님 퐈이팅 !!^^ http://link.com"")
    #                                                                                       end
    #                                    test "@user 아냐 아냥 다음에 또 기회가 잇으니깡 그땐 내가 콘서트 뛰어서 받을게ㅎㅎ" do
    #                                                                                          assert_value KoreanSentenceAnalyser.analyse_sentence("@user 아냐 아냥 다음에 또 기회가 잇으니깡 그땐 내가 콘서트 뛰어서 받을게ㅎㅎ")
    #                                                                                          end
    #                                    test "차마 남에게 말하지 못하는 생각은 하지도 말자... 그리고 그걸 실천할 생각은 더욱더http://link.com" do
    #                                                                                                          assert_value KoreanSentenceAnalyser.analyse_sentence("차마 남에게 말하지 못하는 생각은 하지도 말자... 그리고 그걸 실천할 생각은 더욱더http://link.com")
    #                                                                                                          end
    #                                    test "@user 지금 오시뻐 안되던데....뉴스봉께" do
    #                                                                     assert_value KoreanSentenceAnalyser.analyse_sentence("@user 지금 오시뻐 안되던데....뉴스봉께")
    #                                                                     end
    #                                    test "크리스!!!!!!! ㅠㅡㅠ" do
    #                                                          assert_value KoreanSentenceAnalyser.analyse_sentence("크리스!!!!!!! ㅠㅡㅠ")
    #                                                          end
    #                                    test "@user 안대 부산 못갈거같단말야.." do
    #                                                                 assert_value KoreanSentenceAnalyser.analyse_sentence("@user 안대 부산 못갈거같단말야..")
    #                                                                 end
    #                                    test "@user @user @user @user @user 내사랑오빠들 제가 많이 아끼고 사랑해요♥ #매력터져차서누 #선우현정" do
    #                                                                                                               assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user @user @user @user 내사랑오빠들 제가 많이 아끼고 사랑해요♥ #매력터져차서누 #선우현정")
    #                                                                                                               end
    #                                    test "@user 나루호도랑 오도로키 두마리덕에 제심장이 멀쩡하지않습니다" do
    #                                                                                assert_value KoreanSentenceAnalyser.analyse_sentence("@user 나루호도랑 오도로키 두마리덕에 제심장이 멀쩡하지않습니다")
    #                                                                                end
    #                                    test "@user 팔로해쪄!" do
    #                                                       assert_value KoreanSentenceAnalyser.analyse_sentence("@user 팔로해쪄!")
    #                                                       end
    #                                    test "U+ tv G로 미리보는 브라질 32강 토너먼트 대회에 다녀와서. http://link.com" do
    #                                                                                                assert_value KoreanSentenceAnalyser.analyse_sentence("U+ tv G로 미리보는 브라질 32강 토너먼트 대회에 다녀와서. http://link.com")
    #                                                                                                end
    #                                    test "@user 하하 어디로 모셔드릴까!" do
    #                                                               assert_value KoreanSentenceAnalyser.analyse_sentence("@user 하하 어디로 모셔드릴까!")
    #                                                               end
    #                                    test "@user 그렇습니다 무!상!제!공!" do
    #                                                                assert_value KoreanSentenceAnalyser.analyse_sentence("@user 그렇습니다 무!상!제!공!")
    #                                                                end
    #                                    test "@user @user 맞아...(거울을 본다" do
    #                                                                    assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user 맞아...(거울을 본다")
    #                                                                    end
    #                                    test "@user @user 그런건가.모르겠군." do
    #                                                                  assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user 그런건가.모르겠군.")
    #                                                                  end
    #                                    test "@user 잘자!! 짱좋은꿈꿔!" do
    #                                                             assert_value KoreanSentenceAnalyser.analyse_sentence("@user 잘자!! 짱좋은꿈꿔!")
    #                                                             end
    #                                    test "RT @user: 대통령 악수 거부한 노동당 참관인 http://link.com 저렇게 지들 하고 싶은대로 다 하면서, 맨날 독재타령하지!!" do
    #                                                                                                                          assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 대통령 악수 거부한 노동당 참관인 http://link.com 저렇게 지들 하고 싶은대로 다 하면서, 맨날 독재타령하지!!")
    #                                                                                                                          end
    #                                    test "@user 아 지오님 좀 자요ㅇㅁㅇ(때림" do
    #                                                                  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 아 지오님 좀 자요ㅇㅁㅇ(때림")
    #                                                                  end
    #                                    test "@user 낼만 고생하면 또 쉬잖아요. ㅋㅋ" do
    #                                                                    assert_value KoreanSentenceAnalyser.analyse_sentence("@user 낼만 고생하면 또 쉬잖아요. ㅋㅋ")
    #                                                                    end
    #                                    test "아 뻘하고 공식언라 트윗 인장이 타이렐이 빼꼼해서 ㅋㅋㅋㅋㅋㅋ 넘 귀여워서 뭐지 했어" do
    #                                                                                           assert_value KoreanSentenceAnalyser.analyse_sentence("아 뻘하고 공식언라 트윗 인장이 타이렐이 빼꼼해서 ㅋㅋㅋㅋㅋㅋ 넘 귀여워서 뭐지 했어")
    #                                                                                           end
    #                                    test "한번쯤은 내 쪽에서 먼저 다가가는것도 나쁘..진.. 않겠지..만..." do
    #                                                                                  assert_value KoreanSentenceAnalyser.analyse_sentence("한번쯤은 내 쪽에서 먼저 다가가는것도 나쁘..진.. 않겠지..만...")
    #                                                                                  end
    #                                    test "Oppa why you so handsome ? :o RT @user: 투표합시다 http://link.com"" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("Oppa why you so handsome ? :o RT @user: 투표합시다 http://link.com"")
    #                                                                                                                 end
    #                                                                                                                 test "@user 미친ㅋㅋㅋㅋ 다른 사람이 내 그림에 태그달 수 있어 ㄷㄷㄷ?" do
    #                                                                                                                                                                assert_value KoreanSentenceAnalyser.analyse_sentence("@user 미친ㅋㅋㅋㅋ 다른 사람이 내 그림에 태그달 수 있어 ㄷㄷㄷ?")
    #                                                                                                                                                                end
    #                                    test "[Daum희망해]소연이의 꿈을 연주할 플룻을 선물해주세요 http://link.com" do
    #                                                                                           assert_value KoreanSentenceAnalyser.analyse_sentence("[Daum희망해]소연이의 꿈을 연주할 플룻을 선물해주세요 http://link.com")
    #                                                                                           end
    #                                    test "이따 일어나서 또 갤러리 싹 정리해야되겠다ㅋㅋㅋㅋㅋㅋㅋㅋ" do
    #                                                                           assert_value KoreanSentenceAnalyser.analyse_sentence("이따 일어나서 또 갤러리 싹 정리해야되겠다ㅋㅋㅋㅋㅋㅋㅋㅋ")
    #                                                                           end
    #                                    test "@user 와따시" do
    #                                                     assert_value KoreanSentenceAnalyser.analyse_sentence("@user 와따시")
    #                                                     end
    #                                    test "이걸로 오늘 50점째…." do
    #                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("이걸로 오늘 50점째….")
    #                                                         end
    #                                    test "클라우드 펀딩 관련 법개정 된다고 하니 Kickup 빨리 만들어서 시스템을 판매해야겠다... ^^" do
    #                                                                                                  assert_value KoreanSentenceAnalyser.analyse_sentence("클라우드 펀딩 관련 법개정 된다고 하니 Kickup 빨리 만들어서 시스템을 판매해야겠다... ^^")
    #                                                                                                  end
    #                                    test "더 킹오브파이터즈 M CBT 프리뷰 엔비디아 쉴드 게임패드 세계최초 영상 공개 http://link.com" do
    #                                                                                                       assert_value KoreanSentenceAnalyser.analyse_sentence("더 킹오브파이터즈 M CBT 프리뷰 엔비디아 쉴드 게임패드 세계최초 영상 공개 http://link.com")
    #                                                                                                       end
    #                                    test "@user ㅠㅠㅠㅠㅠㅠ" do
    #                                                        assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅠㅠㅠㅠㅠㅠ")
    #                                                        end
    #                                    test "@user 앗 후배님 고마워요 ♡♥♥♥♥♥" do
    #                                                                   assert_value KoreanSentenceAnalyser.analyse_sentence("@user 앗 후배님 고마워요 ♡♥♥♥♥♥")
    #                                                                   end
    #                                    test "@user zzzzzㅋㅋㅋㅋㅋㅋㅋㅋㅋ  괄다가 너무 이쁜거시다 ㅇ&lt;-&lt; 0~(:3&lt;    )" do
    #                                                                                                        assert_value KoreanSentenceAnalyser.analyse_sentence("@user zzzzzㅋㅋㅋㅋㅋㅋㅋㅋㅋ  괄다가 너무 이쁜거시다 ㅇ&lt;-&lt; 0~(:3&lt;    )")
    #                                                                                                        end
    #                                    test "@user 참여할께요ㅠㅠㅠㅠ항상감사합니다ㅠㅠㅠㅠ♥♥♥" do
    #                                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user 참여할께요ㅠㅠㅠㅠ항상감사합니다ㅠㅠㅠㅠ♥♥♥")
    #                                                                         end
    #                                    test "RT @user: 민규오빠.... 비타민일 뿐인데 예능에서 이렇게 멋있어도 되는거 있기없기?... 😭💕 #플라이투더스카이 #너를너를너를 #브라이언 http://link.com" do
    #                                                                                                                                               assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 민규오빠.... 비타민일 뿐인데 예능에서 이렇게 멋있어도 되는거 있기없기?... 😭💕 #플라이투더스카이 #너를너를너를 #브라이언 http://link.com")
    #                                                                                                                                               end
    #                                    test "뭐지 콘ㄴ서트에서 제일 소름돋았던게 어느 부분이냐면ㄴ 그 종인이 솔로무대 마지막에 뭐라뭐라 나레이션 나오고 종인이가 엔딩포즈 딱 했는데 뒤에서 멤ㅁ버들이 중독 시작하는 대형으로 딱 나올ㄹ때 개소름" do
    #                                                                                                                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("뭐지 콘ㄴ서트에서 제일 소름돋았던게 어느 부분이냐면ㄴ 그 종인이 솔로무대 마지막에 뭐라뭐라 나레이션 나오고 종인이가 엔딩포즈 딱 했는데 뒤에서 멤ㅁ버들이 중독 시작하는 대형으로 딱 나올ㄹ때 개소름")
    #                                                                                                                                                         end
    #                                    test "@user 지호.. 음... 언마, ..아..파? 아파는 어디있어?" do
    #                                                                                 assert_value KoreanSentenceAnalyser.analyse_sentence("@user 지호.. 음... 언마, ..아..파? 아파는 어디있어?")
    #                                                                                 end
    #                                    test "@user 나 이거 완전 조아해ㅠㅠㅠㅠㅠㅠ나 딸기 더쿠야ㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠ 나 뽑아줘ㅎㅎㅎ♡" do
    #                                                                                               assert_value KoreanSentenceAnalyser.analyse_sentence("@user 나 이거 완전 조아해ㅠㅠㅠㅠㅠㅠ나 딸기 더쿠야ㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠ 나 뽑아줘ㅎㅎㅎ♡")
    #                                                                                               end
    #                                    test "이젠 우리팀 전적만 쳐봐도 승패를 가릴수 있는 고수가 되엇음" do
    #                                                                             assert_value KoreanSentenceAnalyser.analyse_sentence("이젠 우리팀 전적만 쳐봐도 승패를 가릴수 있는 고수가 되엇음")
    #                                                                             end
    #                                    test "이런 세계안에서 미래는 있는걸까-?" do
    #                                                               assert_value KoreanSentenceAnalyser.analyse_sentence("이런 세계안에서 미래는 있는걸까-?")
    #                                                               end
    #                                    test "@user @user 으잌ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ찬물뜨신물ㄹ왔다갔닼ㅋㅋㅋ" do
    #                                                                                   assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user 으잌ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ찬물뜨신물ㄹ왔다갔닼ㅋㅋㅋ")
    #                                                                                   end
    #                                    test "@user 크레아 정말 귀엽다" do
    #                                                            assert_value KoreanSentenceAnalyser.analyse_sentence("@user 크레아 정말 귀엽다")
    #                                                            end
    #                                    test "@user 나 랭크 한 판 하고 잇을게 친추해 놔" do
    #                                                                       assert_value KoreanSentenceAnalyser.analyse_sentence("@user 나 랭크 한 판 하고 잇을게 친추해 놔")
    #                                                                       end
    #                                    test "@user 아...해시태그...까먹고잇었네요!!!#VIXX 1등만들라면 안까먹어야하는데....#기적" do
    #                                                                                                   assert_value KoreanSentenceAnalyser.analyse_sentence("@user 아...해시태그...까먹고잇었네요!!!#VIXX 1등만들라면 안까먹어야하는데....#기적")
    #                                                                                                   end
    #                                    test "@user ....골드가 있었군요. 레드만 구했는데... 당장 수퍼에...." do
    #                                                                                      assert_value KoreanSentenceAnalyser.analyse_sentence("@user ....골드가 있었군요. 레드만 구했는데... 당장 수퍼에....")
    #                                                                                      end
    #                                    test "@user 미열이라 아프진 않은데 나른함... 뭔가 아침에 갓 인난듯한 기분나쁜 나른함 있잖아여? 그런 정도?" do
    #                                                                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user 미열이라 아프진 않은데 나른함... 뭔가 아침에 갓 인난듯한 기분나쁜 나른함 있잖아여? 그런 정도?")
    #                                                                                                         end
    #                                    test "이제 막 영어를 배우기 시작했기 때문에 대부분의 내용을이해하지 못해서요. 대체로 음악과 가사에 동시에 집중할 수가없기 때문일지 모르죠. 가사와 보컬을 떼어놓고 음악만을 보면 대부분의 경우엔 거칠잖아요.(힙합에 대하여)" do
    #                                                                                                                                                                     assert_value KoreanSentenceAnalyser.analyse_sentence("이제 막 영어를 배우기 시작했기 때문에 대부분의 내용을이해하지 못해서요. 대체로 음악과 가사에 동시에 집중할 수가없기 때문일지 모르죠. 가사와 보컬을 떼어놓고 음악만을 보면 대부분의 경우엔 거칠잖아요.(힙합에 대하여)")
    #                                                                                                                                                                     end
    #                                    test "@user 프로그램인가요 'ω'? 저는 제일 모르는 분야로군요...(심각) 기계랑 안 친한건 아니지만 뭐랄까, 그런거 만드는 사람 보면 신기해요...(반짝반짝)" do
    #                                                                                                                                     assert_value KoreanSentenceAnalyser.analyse_sentence("@user 프로그램인가요 'ω'? 저는 제일 모르는 분야로군요...(심각) 기계랑 안 친한건 아니지만 뭐랄까, 그런거 만드는 사람 보면 신기해요...(반짝반짝)")
    #                                                                                                                                     end
    #                                    test "무료야동보는곳 http://link.com" do
    #                                                                   assert_value KoreanSentenceAnalyser.analyse_sentence("무료야동보는곳 http://link.com")
    #                                                                   end
    # test "...으응, 아무것도 아니야~ ..아! 근처에 괜찮은 케이크 가게가 있다던데, 같이 갈래?" do
    #                                                          assert_value KoreanSentenceAnalyser.analyse_sentence("...으응, 아무것도 아니야~ ..아! 근처에 괜찮은 케이크 가게가 있다던데, 같이 갈래?")
    #                                                          end
    # test "@user 노야 마지미인 http://link.com" do
    #                                     assert_value KoreanSentenceAnalyser.analyse_sentence("@user 노야 마지미인 http://link.com")
    #                                     end
    # test "RT @user: 악수거부는 예의를 갖춘 거죠. 주먹이 날라갔어야 예의 없다 불한당이다 떠들 수 있는 거고!!!" do
    #                                                                      assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 악수거부는 예의를 갖춘 거죠. 주먹이 날라갔어야 예의 없다 불한당이다 떠들 수 있는 거고!!!")
    #                                                                      end
    # test "@user 에헤헤~ http://link.com" do
    #                                  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 에헤헤~ http://link.com")
    #                                  end
    # test "정말 고생 많았습니다. @user" do
    #                          assert_value KoreanSentenceAnalyser.analyse_sentence("정말 고생 많았습니다. @user")
    #                          end
    # test "@user 말레가 아니라면 안경 안쓰셔도 되여! 아 자막은 보이세여?ㅠㅠ" do
    #                                                assert_value KoreanSentenceAnalyser.analyse_sentence("@user 말레가 아니라면 안경 안쓰셔도 되여! 아 자막은 보이세여?ㅠㅠ")
    #                                                end
    # test "@user 미미는까야제맛" do
    #                     assert_value KoreanSentenceAnalyser.analyse_sentence("@user 미미는까야제맛")
    #                     end
    # test "@user 엑데퓨 굿즈안나옴 ㅋ 유팜만 나옴ㅋ" do
    #                                 assert_value KoreanSentenceAnalyser.analyse_sentence("@user 엑데퓨 굿즈안나옴 ㅋ 유팜만 나옴ㅋ")
    #                                 end
    # test "@user ㅋㅋ헛다리.." do
    #                     assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅋㅋ헛다리..")
    #                     end
    # test "@user ㅋㅋㅋ^^" do
    #                   assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅋㅋㅋ^^")
    #                   end
    # test "무료야동보는곳 http://link.com" do
    #                               assert_value KoreanSentenceAnalyser.analyse_sentence("무료야동보는곳 http://link.com")
    #                               end
    # test "@user @user @user @user @user @user @user @user @user @user @user 여유로운 목요일" do
    #                                                                                  assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user @user @user @user @user @user @user @user @user @user 여유로운 목요일")
    #                                                                                  end
    # test "@user 그러게요!!! 제가 뽑은 사람이 되길!!! 교육감은 될꺼가튼데!!!" do
    #                                                   assert_value KoreanSentenceAnalyser.analyse_sentence("@user 그러게요!!! 제가 뽑은 사람이 되길!!! 교육감은 될꺼가튼데!!!")
    #                                                   end
    # test "@user 애니원 채널  ㅠㅠㅠㅠㅠ" do
    #                           assert_value KoreanSentenceAnalyser.analyse_sentence("@user 애니원 채널  ㅠㅠㅠㅠㅠ")
    #                           end
    # test "[Live HD 1080p] 140601 Jiyeon - Never Ever (1분 1초) @ Inkigayo http://link.com" do
    #                                                                                     assert_value KoreanSentenceAnalyser.analyse_sentence("[Live HD 1080p] 140601 Jiyeon - Never Ever (1분 1초) @ Inkigayo http://link.com")
    #                                                                                     end
    # test "눈만으로도알수잇대 😞" do
    #                    assert_value KoreanSentenceAnalyser.analyse_sentence("눈만으로도알수잇대 😞")
    #                    end
    # test "@user 그런 무궁무진한 문제들이 당신의 사고를 파괴시키고 감을 잃게 만들었습니다." do
    #                                                       assert_value KoreanSentenceAnalyser.analyse_sentence("@user 그런 무궁무진한 문제들이 당신의 사고를 파괴시키고 감을 잃게 만들었습니다.")
    #                                                       end
    # test "@user 잘했어요! 원래 아침 안먹던 사람이 아침먹는 격일걸요...부담 안되는것부터 먹고 점점 늘려요-" do
    #                                                                  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 잘했어요! 원래 아침 안먹던 사람이 아침먹는 격일걸요...부담 안되는것부터 먹고 점점 늘려요-")
    #                                                                  end
    # test "@user 나도 시험기간이야..ㅠㅠ" do
    #                           assert_value KoreanSentenceAnalyser.analyse_sentence("@user 나도 시험기간이야..ㅠㅠ")
    #                           end
    # test "@user 헐........미친거아님? 신고=_=;;;;;;;;;;;;;;;;;;;;;;" do
    #                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user 헐........미친거아님? 신고=_=;;;;;;;;;;;;;;;;;;;;;;")
    #                                                         end
    # test "@user 그로묜 안돼 ㅠㅠ 일단 학생의 본분은 열심히 하는걸류로 ㅠㅠㅠㅠ" do
    #                                                 assert_value KoreanSentenceAnalyser.analyse_sentence("@user 그로묜 안돼 ㅠㅠ 일단 학생의 본분은 열심히 하는걸류로 ㅠㅠㅠㅠ")
    #                                                 end
    # test "@user 스퍼터는 스카프 뜯어갈꺼야 ㅋㅋㅋㅋㅋ" do
    #                                  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 스퍼터는 스카프 뜯어갈꺼야 ㅋㅋㅋㅋㅋ")
    #                                  end
    # test "모두 일어나는가. 과인도 정무를 다보고 그대들과 패도를 논하러 왔다." do
    #                                              assert_value KoreanSentenceAnalyser.analyse_sentence("모두 일어나는가. 과인도 정무를 다보고 그대들과 패도를 논하러 왔다.")
    #                                              end
    # test "@user 넹 라됴헤드...ㅋㅋㅋㅋㅋㅋ" do
    #                             assert_value KoreanSentenceAnalyser.analyse_sentence("@user 넹 라됴헤드...ㅋㅋㅋㅋㅋㅋ")
    #                             end
    # test "@user 글야됴요..." do
    #                     assert_value KoreanSentenceAnalyser.analyse_sentence("@user 글야됴요...")
    #                     end
    # test "@user 하하, 좋아. 그럼 어차피 시작이고 처음이니까, 머리도 식힐겸 아까 나왔던 최저임금 인상을 가지고 얘기해볼까? 대사라거나 그런 것도 상당히 중요할 것 같은데.. 생각해보니까 잘못하면 순식간에 쿠데타라도 일어날지도 모르잖아." do
    #                                                                                                                                          assert_value KoreanSentenceAnalyser.analyse_sentence("@user 하하, 좋아. 그럼 어차피 시작이고 처음이니까, 머리도 식힐겸 아까 나왔던 최저임금 인상을 가지고 얘기해볼까? 대사라거나 그런 것도 상당히 중요할 것 같은데.. 생각해보니까 잘못하면 순식간에 쿠데타라도 일어날지도 모르잖아.")
    #                                                                                                                                          end
    # test "본계 팔로워를 정리해야하나. 뭔가 갈수록 저쪽 사람들 마음에 안든다." do
    #                                              assert_value KoreanSentenceAnalyser.analyse_sentence("본계 팔로워를 정리해야하나. 뭔가 갈수록 저쪽 사람들 마음에 안든다.")
    #                                              end
    # test "@user ㅜㅜ흑흑 진짜 자상남...♡ 넘 조아♥" do
    #                                   assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅜㅜ흑흑 진짜 자상남...♡ 넘 조아♥")
    #                                   end
    # test "경기도도 따라 갑니다...ㅋ 박근혜 포도대장 남경필이 네 이놈....ㅋ" do
    #                                               assert_value KoreanSentenceAnalyser.analyse_sentence("경기도도 따라 갑니다...ㅋ 박근혜 포도대장 남경필이 네 이놈....ㅋ")
    #                                               end
    # test "@user 잘부탁드려요 &gt;_+" do
    #                           assert_value KoreanSentenceAnalyser.analyse_sentence("@user 잘부탁드려요 &gt;_+")
    #                           end
    # test "나도 피시방 가게 해줘 이 개같은 강의.. 교수님은 왜 중간에 바뀌어가지구 일케 생고생" do
    #                                                        assert_value KoreanSentenceAnalyser.analyse_sentence("나도 피시방 가게 해줘 이 개같은 강의.. 교수님은 왜 중간에 바뀌어가지구 일케 생고생")
    #                                                        end
    # test "*나는 바다같은 사람이래요. 나하고 친해지면, 내 속에 너무 깊이 들어오면, 당신이 숨이 막힐까봐. 너무 깊이 내려가서 압력에 터져버릴까봐. 나는 너무 무서워요." do
    #                                                                                                  assert_value KoreanSentenceAnalyser.analyse_sentence("*나는 바다같은 사람이래요. 나하고 친해지면, 내 속에 너무 깊이 들어오면, 당신이 숨이 막힐까봐. 너무 깊이 내려가서 압력에 터져버릴까봐. 나는 너무 무서워요.")
    #                                                                                                  end
    # test "@user 뭐 이런걸로 ." do
    #                      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 뭐 이런걸로 .")
    #                      end
    # test "@user ㅋㅌㅋㅌㅋㅌㅋㅌㅋㅋㅌㅋ (허탈한 웃음을 지어보엿다-" do
    #                                          assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅋㅌㅋㅌㅋㅌㅋㅌㅋㅋㅌㅋ (허탈한 웃음을 지어보엿다-")
    #                                          end
    # test "@user 첸.모에 http://link.com" do
    #                                  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 첸.모에 http://link.com")
    #                                  end
    # test "힌다해놓고 안하는게 이상한거다,흐흥." do
    #                            assert_value KoreanSentenceAnalyser.analyse_sentence("힌다해놓고 안하는게 이상한거다,흐흥.")
    #                            end
    # test "12시 10분에 기숙사 들어옴 ㅠㅠ ㅠㅠㅠ" do
    #                               assert_value KoreanSentenceAnalyser.analyse_sentence("12시 10분에 기숙사 들어옴 ㅠㅠ ㅠㅠㅠ")
    #                               end
    # test "나는 당신이 피식피식 웃는 모습이, 그 때의 목소리가 좋았다. 하지만 당신이 웃는 모습은 무척이나 보기 힘들었고, 그래서 나는 당신 앞에서는, 당신이 아는 모든 곳에서는 광대로 남기로 했다. 그렇게 해서 당신이 웃어준다면 그걸로 충분했으니까." do
    #                                                                                                                                               assert_value KoreanSentenceAnalyser.analyse_sentence("나는 당신이 피식피식 웃는 모습이, 그 때의 목소리가 좋았다. 하지만 당신이 웃는 모습은 무척이나 보기 힘들었고, 그래서 나는 당신 앞에서는, 당신이 아는 모든 곳에서는 광대로 남기로 했다. 그렇게 해서 당신이 웃어준다면 그걸로 충분했으니까.")
    #                                                                                                                                               end
    # test "@user 헉헉대며 카,아니 유키오! 나 좋아하죠?!나,나,나!나 좋아하는거죠!? 라며 사람들속에서 소리치니까 지나가던 사람들의 시선이 다 키세로 몰리고 그중에 키사랑 카사마츠 알아보는 사람도있고 카사마츠는 당황해서 물먹은소리로" do
    #                                                                                                                                       assert_value KoreanSentenceAnalyser.analyse_sentence("@user 헉헉대며 카,아니 유키오! 나 좋아하죠?!나,나,나!나 좋아하는거죠!? 라며 사람들속에서 소리치니까 지나가던 사람들의 시선이 다 키세로 몰리고 그중에 키사랑 카사마츠 알아보는 사람도있고 카사마츠는 당황해서 물먹은소리로")
    #                                                                                                                                       end
    # test ""@user: @user 내가 얼굴이 아가쟈나..ㅎ" 동네사람들...!" do
    #                                               assert_value KoreanSentenceAnalyser.analyse_sentence(""@user: @user 내가 얼굴이 아가쟈나..ㅎ" 동네사람들...!")
    #                                               end
    #                                  test "(그러고 본인은 쪼르르 방밖으로 나가서 쿠키랑 논다)" do
    #                                                                       assert_value KoreanSentenceAnalyser.analyse_sentence("(그러고 본인은 쪼르르 방밖으로 나가서 쿠키랑 논다)")
    #                                                                       end
    #                                  test "쓸데없는 얘기는 됐고, 너 원고는 하고 있는 거야? 설마 그동안 시간 낭비만 하고 있었던 건 아니겠지?" do
    #                                                                                                   assert_value KoreanSentenceAnalyser.analyse_sentence("쓸데없는 얘기는 됐고, 너 원고는 하고 있는 거야? 설마 그동안 시간 낭비만 하고 있었던 건 아니겠지?")
    #                                                                                                   end
    #                                  test "@user ...??제가 왜요!" do
    #                                                           assert_value KoreanSentenceAnalyser.analyse_sentence("@user ...??제가 왜요!")
    #                                                           end
    #                                  test "@user 고맙그ㅠㅠㅠㅠㅠㅠ♥" do
    #                                                          assert_value KoreanSentenceAnalyser.analyse_sentence("@user 고맙그ㅠㅠㅠㅠㅠㅠ♥")
    #                                                          end
    # test "@user 피곤해요 근데ㅋㅋㅋㅋ 일곱시간 못자서..." do
    #                                     assert_value KoreanSentenceAnalyser.analyse_sentence("@user 피곤해요 근데ㅋㅋㅋㅋ 일곱시간 못자서...")
    #                                     end
    # test "@user 헐ㅋㅋㅋㅋㅋㅋ겁나 빡쎄!!! 그것만 버티면 3일동안 쉬니까...힘내.." do
    #                                                     assert_value KoreanSentenceAnalyser.analyse_sentence("@user 헐ㅋㅋㅋㅋㅋㅋ겁나 빡쎄!!! 그것만 버티면 3일동안 쉬니까...힘내..")
    #                                                     end
    # test ""예수 믿고 구원받으세요"" do
    #                      assert_value KoreanSentenceAnalyser.analyse_sentence(""예수 믿고 구원받으세요"")
    #                      end
    # test "손수조는 "도와달라" 호소하는데 당직자는 일인시위하는 시민들에게"쓰레기야" 시비..." do
    #                                                       assert_value KoreanSentenceAnalyser.analyse_sentence("손수조는 "도와달라" 호소하는데 당직자는 일인시위하는 시민들에게"쓰레기야" 시비...")
    #                                                       end
    # test "#Self_intro #with_me 19남, 사이퍼즈!!/우리 같이 놀아요~♬ 씬나는 트위터~세상속~♬" do
    #                                                                  assert_value KoreanSentenceAnalyser.analyse_sentence("#Self_intro #with_me 19남, 사이퍼즈!!/우리 같이 놀아요~♬ 씬나는 트위터~세상속~♬")
    #                                                                  end
    # test "4. 형이 나꼼수를 듣고있는데 그때도 내가 자고있던 도중이었음. 나꼼수 듣다가 깨서 분노. 결론은 마찬가지" do
    #                                                                   assert_value KoreanSentenceAnalyser.analyse_sentence("4. 형이 나꼼수를 듣고있는데 그때도 내가 자고있던 도중이었음. 나꼼수 듣다가 깨서 분노. 결론은 마찬가지")
    #                                                                   end
    # test "@user 아 공앱새끼 또 알림 씹어드셨네" do
    #                               assert_value KoreanSentenceAnalyser.analyse_sentence("@user 아 공앱새끼 또 알림 씹어드셨네")
    #                               end
    # test "@user ㅋㅋㅋㅋㅋㅋ 그렇긴 하네 근데 다들 중꿔가 이쁘다고 해서 고민임 ㅜㅜㅜ 걍 윔업은 쭝꿔 경기복은 코랜에서 살까........" do
    #                                                                                   assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅋㅋㅋㅋㅋㅋ 그렇긴 하네 근데 다들 중꿔가 이쁘다고 해서 고민임 ㅜㅜㅜ 걍 윔업은 쭝꿔 경기복은 코랜에서 살까........")
    #                                                                                   end
    # test "RT @user: 헷 성인커뮤 뛸 수 있당ㅎ 그치만 그만큼 존잘님들이 너무 많당ㅎ #RT" do
    #                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 헷 성인커뮤 뛸 수 있당ㅎ 그치만 그만큼 존잘님들이 너무 많당ㅎ #RT")
    #                                                         end
    # test "@user @user 근데 왜 산체ㅡ그는 화장실을 벌써 다녀온거야" do
    #                                            assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user 근데 왜 산체ㅡ그는 화장실을 벌써 다녀온거야")
    #                                            end
    # test "@user 좀 나이 많은 캐를 좋아하면 안심돼... 내가 얘 탈덕할때까지 아저씨로 남겠구나 싶어서ㅋㅋㅋ" do
    #                                                                 assert_value KoreanSentenceAnalyser.analyse_sentence("@user 좀 나이 많은 캐를 좋아하면 안심돼... 내가 얘 탈덕할때까지 아저씨로 남겠구나 싶어서ㅋㅋㅋ")
    #                                                                 end
    # test "@user 그럼. (서류 보드 하나 꺼내서 준의 머리를 내려치며) 어른한테 버릇 없이 말버릇이 그게 뭡니까." do
    #                                                                    assert_value KoreanSentenceAnalyser.analyse_sentence("@user 그럼. (서류 보드 하나 꺼내서 준의 머리를 내려치며) 어른한테 버릇 없이 말버릇이 그게 뭡니까.")
    #                                                                    end
    # test "@user 하니 메일도 화이팅! ♥ 7일의 드림 콘서트 가니까요? ^^" do
    #                                               assert_value KoreanSentenceAnalyser.analyse_sentence("@user 하니 메일도 화이팅! ♥ 7일의 드림 콘서트 가니까요? ^^")
    #                                               end
    # test "RT @user: 닌자르메 파업 다메요ㅠㅠ" do
    #                               assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 닌자르메 파업 다메요ㅠㅠ")
    #                               end
    # test "@user 앜ㅋㅋㅋ바로 그거락우옄ㅋㅋㅋㅋ 물개박수 치면서 조아했네옄ㅋㅋㅋㅋㅋ" do
    #                                                  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 앜ㅋㅋㅋ바로 그거락우옄ㅋㅋㅋㅋ 물개박수 치면서 조아했네옄ㅋㅋㅋㅋㅋ")
    #                                                  end
    # test "@user 뭐 먹을꺼야?(메뉴판을 둘러보며) 난 베이컨 에그 샌드위치랑 토마토주스!" do
    #                                                      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 뭐 먹을꺼야?(메뉴판을 둘러보며) 난 베이컨 에그 샌드위치랑 토마토주스!")
    #                                                      end
    # test "내가 이구역의 덕후다(실성 http://link.com" do
    #                                      assert_value KoreanSentenceAnalyser.analyse_sentence("내가 이구역의 덕후다(실성 http://link.com")
    #                                      end
    # test "@user 으아아아아ㅏ 엠씨 안 돼여ㅠㅠㅜ 나쁘다 스피커 나쁘다ㅠㅠㅠ 히이익ㅠㅠㅠ 엠씨 죽디마요ㅜㅜㅜ ㄹ고 저만 멘붕중이겠죠... 스피커씨는 그저 조용히 엠씨가 죽어가는 과정을 끝까지 지켜보다가 시체 처리도 안하고 돌아갈 것 같아요ㅠㅠㅠ" do
    #                                                                                                                                            assert_value KoreanSentenceAnalyser.analyse_sentence("@user 으아아아아ㅏ 엠씨 안 돼여ㅠㅠㅜ 나쁘다 스피커 나쁘다ㅠㅠㅠ 히이익ㅠㅠㅠ 엠씨 죽디마요ㅜㅜㅜ ㄹ고 저만 멘붕중이겠죠... 스피커씨는 그저 조용히 엠씨가 죽어가는 과정을 끝까지 지켜보다가 시체 처리도 안하고 돌아갈 것 같아요ㅠㅠㅠ")
    #                                                                                                                                            end
    # test "ㅋㅋㅋ 다봤지롱~ RT @user: http://link.com" do
    #                                           assert_value KoreanSentenceAnalyser.analyse_sentence("ㅋㅋㅋ 다봤지롱~ RT @user: http://link.com")
    #                                           end
    # test ""@user: [Dujun Yoseob] RT  @user  ·  140315 제프투어 in 도쿄, 요섭이 번쩍 들어올리는 두준이는 보나쓰! 겸둥이들❤ http://link.com"" do
    #                                                                                                             assert_value KoreanSentenceAnalyser.analyse_sentence(""@user: [Dujun Yoseob] RT  @user  ·  140315 제프투어 in 도쿄, 요섭이 번쩍 들어올리는 두준이는 보나쓰! 겸둥이들❤ http://link.com"")
    #                                                                                                             end
    #                           test "@user 근데 우지코는여?" do
    #                                                  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 근데 우지코는여?")
    #                                                  end
    #                           test "@user @user 조아조아.. 언니는 ㅌ퇴근 몇시지?" do
    #                                                                  assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user 조아조아.. 언니는 ㅌ퇴근 몇시지?")
    #                                                                  end
    #                           test "RT @user: 그리고 또 오늘 http://link.com" do
    #                                                                     assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 그리고 또 오늘 http://link.com")
    #                                                                     end
    #                           test "RT @user: 6.4 지방선거 투표율 17시 현재 51.8% http://link.com" do
    #                                                                                      assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 6.4 지방선거 투표율 17시 현재 51.8% http://link.com")
    #                                                                                      end
    #                           test "@user 아, 개부럽;" do
    #                                                assert_value KoreanSentenceAnalyser.analyse_sentence("@user 아, 개부럽;")
    #                                                end
    #                           test "저녁 완전체 번데기+달ㄱ발 그리거 소주 http://link.com" do
    #                                                                        assert_value KoreanSentenceAnalyser.analyse_sentence("저녁 완전체 번데기+달ㄱ발 그리거 소주 http://link.com")
    #                                                                        end
    #                           test "@user 아 푸솬이시군요 타지역이여도 오거돈 응원해요ㅠㅠ" do
    #                                                                   assert_value KoreanSentenceAnalyser.analyse_sentence("@user 아 푸솬이시군요 타지역이여도 오거돈 응원해요ㅠㅠ")
    #                                                                   end
    #                           test "@user 나도...나도!" do
    #                                                 assert_value KoreanSentenceAnalyser.analyse_sentence("@user 나도...나도!")
    #                                                 end
    #                           test "@user 아? 제 연애운도 좀 봐주시면?" do
    #                                                          assert_value KoreanSentenceAnalyser.analyse_sentence("@user 아? 제 연애운도 좀 봐주시면?")
    #                                                          end
    #                           test "@user 초코빙수 별로임 눈ㄴ꽃빙수가개짱" do
    #                                                          assert_value KoreanSentenceAnalyser.analyse_sentence("@user 초코빙수 별로임 눈ㄴ꽃빙수가개짱")
    #                                                          end
    #                           test "리복 인스타 잉어 http://link.com" do
    #                                                            assert_value KoreanSentenceAnalyser.analyse_sentence("리복 인스타 잉어 http://link.com")
    #                                                            end
    #                           test "@user .....ㅎ...ㅎ...ㅎ.." do
    #                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user .....ㅎ...ㅎ...ㅎ..")
    #                                                         end
    #                           test "RT @user: 아이유, ＇소극장 콘서트＇ 온 팬들에게 ＇역조공＇…＂센스쟁이＂ #MToday http://link.com IU's FANSERVICE IS LEGENDARY! #IU #Concert #Fanservice" do
    #                                                                                                                                                              assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 아이유, ＇소극장 콘서트＇ 온 팬들에게 ＇역조공＇…＂센스쟁이＂ #MToday http://link.com IU's FANSERVICE IS LEGENDARY! #IU #Concert #Fanservice")
    #                                                                                                                                                              end
    #                           test "@user 앗 루카님 오랜만이에요 헤헤 *' '* 동네길래 왠지 신경쓰여서요 ㅠㅠㅠㅠ" do
    #                                                                                  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 앗 루카님 오랜만이에요 헤헤 *' '* 동네길래 왠지 신경쓰여서요 ㅠㅠㅠㅠ")
    #                                                                                  end
    #                           test "@user 난 봇이랑 안노는데다 관전만 하고 갠봇 있어도 쟤보다 더 좋아하진 않을것같고 최애캐도 잘 없고 뭣보다 저새끼가 너무 눈새라 내 계정도 못찾고 찾아도 트윗수 잴생각은 못해보고 냅둘듯 차라리 이제 한결 편해지겠구나 하면모를까" do
    #                                                                                                                                                                    assert_value KoreanSentenceAnalyser.analyse_sentence("@user 난 봇이랑 안노는데다 관전만 하고 갠봇 있어도 쟤보다 더 좋아하진 않을것같고 최애캐도 잘 없고 뭣보다 저새끼가 너무 눈새라 내 계정도 못찾고 찾아도 트윗수 잴생각은 못해보고 냅둘듯 차라리 이제 한결 편해지겠구나 하면모를까")
    #                                                                                                                                                                    end
    #                           test "RT @user: @user @user 우♡리♡모♡두♡슈♡스♡?♡" do
    #                                                                       assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: @user @user 우♡리♡모♡두♡슈♡스♡?♡")
    #                                                                       end
    #                           test "@user 저도욬ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ" do
    #                                                                  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 저도욬ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ")
    #                                                                  end
    #                           test "RT @user: 천칭 씨의 눈치가 어설픈 점 하나 더." do
    #                                                                  assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 천칭 씨의 눈치가 어설픈 점 하나 더.")
    #                                                                  end
    #                           test "손등에도 도장을 찍었지만 이미 번지고 있다. 다이어리에 찍어와서 다행이군. 자- 이제 뭐할까?" do
    #                                                                                       assert_value KoreanSentenceAnalyser.analyse_sentence("손등에도 도장을 찍었지만 이미 번지고 있다. 다이어리에 찍어와서 다행이군. 자- 이제 뭐할까?")
    #                                                                                       end
    #                           test "난 말로만 디지캐럿 디지캐럿했지 실제론 플사도 디지캐럿 캐릭터가 아닌 매국노였다." do
    #                                                                                assert_value KoreanSentenceAnalyser.analyse_sentence("난 말로만 디지캐럿 디지캐럿했지 실제론 플사도 디지캐럿 캐릭터가 아닌 매국노였다.")
    #                                                                                end
    #                           test "조폭도 좋고 마피아도 좋아!!!!!!!!!!!" do
    #                                                            assert_value KoreanSentenceAnalyser.analyse_sentence("조폭도 좋고 마피아도 좋아!!!!!!!!!!!")
    #                                                            end
    #                           test "@user 흐에에어ㅓㅓ유ㅜㅠㅜㅜ 선배님 맛있사옵니까 ㅠㅜㅠㅜ" do
    #                                                                    assert_value KoreanSentenceAnalyser.analyse_sentence("@user 흐에에어ㅓㅓ유ㅜㅠㅜㅜ 선배님 맛있사옵니까 ㅠㅜㅠㅜ")
    #                                                                    end
    #                           test "우수에 찬 눈 빛 ㅇㅁㅇ http://link.com" do
    #                                                                assert_value KoreanSentenceAnalyser.analyse_sentence("우수에 찬 눈 빛 ㅇㅁㅇ http://link.com")
    #                                                                end
    #                           test "*자고 있어?! 그렇게네 데이트가 피곤했나?!.*" do
    #                                                              assert_value KoreanSentenceAnalyser.analyse_sentence("*자고 있어?! 그렇게네 데이트가 피곤했나?!.*")
    #                                                              end
    #                           test "@user 지자체 부도에 대해서 찾아보니 딱히 어떻게 된다.. 뭐 그런건 안나와서 잘 모르겠는데.. 일본같은 경우 버스비 10만원 뭐 그런식으로 세금 걷어서 갚으려는데 시민들 다 떠나고.." do
    #                                                                                                                                            assert_value KoreanSentenceAnalyser.analyse_sentence("@user 지자체 부도에 대해서 찾아보니 딱히 어떻게 된다.. 뭐 그런건 안나와서 잘 모르겠는데.. 일본같은 경우 버스비 10만원 뭐 그런식으로 세금 걷어서 갚으려는데 시민들 다 떠나고..")
    #                                                                                                                                            end
    #                           test "빅스들아..........어린이대공원은 참 좋은 곳이야........" do
    #                                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("빅스들아..........어린이대공원은 참 좋은 곳이야........")
    #                                                                         end
    #                           test "@user 마틴때리고싶어(침착" do
    #                                                   assert_value KoreanSentenceAnalyser.analyse_sentence("@user 마틴때리고싶어(침착")
    #                                                   end
    #                           test "@user 하려고 ㅋ 넌?" do
    #                                                 assert_value KoreanSentenceAnalyser.analyse_sentence("@user 하려고 ㅋ 넌?")
    #                                                 end
    #                           test "@user 네 닥온 때 기대할게요 ^^" do
    #                                                        assert_value KoreanSentenceAnalyser.analyse_sentence("@user 네 닥온 때 기대할게요 ^^")
    #                                                        end
    #                           test "내 트친중에 여자가 더 있었다니" do
    #                                                    assert_value KoreanSentenceAnalyser.analyse_sentence("내 트친중에 여자가 더 있었다니")
    #                                                    end
    #                           test "바로, 사람의 '오만함'때문이지" do
    #                                                    assert_value KoreanSentenceAnalyser.analyse_sentence("바로, 사람의 '오만함'때문이지")
    #                                                    end
    #                           test ""뽀뽀 를 했니....?" ㅋㅋㅋㅋ" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence(""뽀뽀 를 했니....?" ㅋㅋㅋㅋ")
    #    end
    #    test "헐. 오늘 열비큐에 사장님 출근.. " @ Yeolsoon 비비큐 성열 안녕하세용.... 레몬에이드 감사합니당....... 악수 고맙습니당........ 오늘 왜케 귀여우세요 ㅜㅅㅜ♡ http://link.com"" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("헐. 오늘 열비큐에 사장님 출근.. " @ Yeolsoon 비비큐 성열 안녕하세용.... 레몬에이드 감사합니당....... 악수 고맙습니당........ 오늘 왜케 귀여우세요 ㅜㅅㅜ♡ http://link.com"")
    #    end
    #    test "RT @user: 길드 3엘프녀 한복특집 http://link.com" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 길드 3엘프녀 한복특집 http://link.com")
    #    end
    #    test "@user 서포터는 궁빨이나 힐빨이 있어서 한타때 어떻게든 궁 맞추면 0.8인분은 할 수 있음.. 나머지 0.2는 시야장악으로 할 수밖에 없음 나 라인전 망하면 셀프시즌3로 돌아감 시야석 살 돈도 없어 와드 사고 박느라고" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 서포터는 궁빨이나 힐빨이 있어서 한타때 어떻게든 궁 맞추면 0.8인분은 할 수 있음.. 나머지 0.2는 시야장악으로 할 수밖에 없음 나 라인전 망하면 셀프시즌3로 돌아감 시야석 살 돈도 없어 와드 사고 박느라고")
    #    end
    #    test "일출 13분 남았어요!! 히히" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("일출 13분 남았어요!! 히히")
    #    end
    #    test "@user 풋. 이미 오늘만 해도 도움이 되었다. (웃음) 노래라. 반짝반짝 트잉☆ 이런 느낌이려나. ㅁ-ㅁ+ 너는 커피. 나는 차." do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 풋. 이미 오늘만 해도 도움이 되었다. (웃음) 노래라. 반짝반짝 트잉☆ 이런 느낌이려나. ㅁ-ㅁ+ 너는 커피. 나는 차.")
    #    end
    #    test "늦으막히 공약확인하고 투표하고옴ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ 아제들 겁나많넹" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("늦으막히 공약확인하고 투표하고옴ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ 아제들 겁나많넹")
    #    end
    #    test "존...? (바위에게 속삭인다) 존. 저 좀 도와주십시요. (바위를 똑똑 두드린다)" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("존...? (바위에게 속삭인다) 존. 저 좀 도와주십시요. (바위를 똑똑 두드린다)")
    #    end
    #    test "@user 야아, 그건 심했다. (긁적)" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 야아, 그건 심했다. (긁적)")
    #    end
    #    test "라이크잇보다 글리터가 쉽습니다 ㅋ http://link.com" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("라이크잇보다 글리터가 쉽습니다 ㅋ http://link.com")
    #    end
    #    test "그려보고싶은건 많은데 손이안따라주네ㅠ.ㅜ" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("그려보고싶은건 많은데 손이안따라주네ㅠ.ㅜ")
    #    end
    #    test "RT @user: 무밍 http://link.com" do
    #      assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 무밍 http://link.com")
    #    end
    #    test "그래 다 그렇다치는데 내가 궁금한것은 그런 상태의 부활 전사들이 어째서 왜 무엇때문에 성녀를 위해 싸우는건데??? 그 연결고리는 어디?" do
    #                                                                                       assert_value KoreanSentenceAnalyser.analyse_sentence("그래 다 그렇다치는데 내가 궁금한것은 그런 상태의 부활 전사들이 어째서 왜 무엇때문에 성녀를 위해 싸우는건데??? 그 연결고리는 어디?")
    #                                                                                       end
    # test "@user :0.....푹쉬어요!!!" do
    #                            assert_value KoreanSentenceAnalyser.analyse_sentence("@user :0.....푹쉬어요!!!")
    #                            end
    # test "RT @user: 봇계:그러니까..뫄뫄의 사망원인은..!" do
    #                                       assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 봇계:그러니까..뫄뫄의 사망원인은..!")
    #                                       end
    # test "@user 걸려도 뭐.. 막무가내랔ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ 거기다 걔들 밥 항상 남았구! ㅋㅋㅋㅋㅋㅋ 애들이 미쳐서 날뛰느라 더했어욬ㅋㅋㅋㅋㅋㅋㅋ 누가 수업중에 신호가 온다고 하면 온 반이 환호하면서 성공을 기원하고..미친.." do
    #                                                                                                                                   assert_value KoreanSentenceAnalyser.analyse_sentence("@user 걸려도 뭐.. 막무가내랔ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ 거기다 걔들 밥 항상 남았구! ㅋㅋㅋㅋㅋㅋ 애들이 미쳐서 날뛰느라 더했어욬ㅋㅋㅋㅋㅋㅋㅋ 누가 수업중에 신호가 온다고 하면 온 반이 환호하면서 성공을 기원하고..미친..")
    #                                                                                                                                   end
    # test "@user 언젠 안하신것처럼" do
    #                       assert_value KoreanSentenceAnalyser.analyse_sentence("@user 언젠 안하신것처럼")
    #                       end
    # test "단게이쇼는 뭐랄까...신캐정보 캐내려고 유저와 개발자의 눈치싸움 같다" do
    #                                              assert_value KoreanSentenceAnalyser.analyse_sentence("단게이쇼는 뭐랄까...신캐정보 캐내려고 유저와 개발자의 눈치싸움 같다")
    #                                              end
    # test "@user 에벱뻬ㅔ베ㅔ베ㅔ http://link.com" do
    #                                      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 에벱뻬ㅔ베ㅔ베ㅔ http://link.com")
    #                                      end
    # test "@user 타락쏘지 끙끙... 짱짱.. 생각해보니 민아 시그너스랑 짱짱 잘 어울리네여 둘이 강아지상인게 은근 닯았고ㅋㅋㅋㅋㅋㅋㅋㅋㅋ 민아가 기사단이라니 정령 소환하는 민아 보고싶네여ㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠ 흡 민아야 기사단 제복 입어조...." do
    #                                                                                                                                            assert_value KoreanSentenceAnalyser.analyse_sentence("@user 타락쏘지 끙끙... 짱짱.. 생각해보니 민아 시그너스랑 짱짱 잘 어울리네여 둘이 강아지상인게 은근 닯았고ㅋㅋㅋㅋㅋㅋㅋㅋㅋ 민아가 기사단이라니 정령 소환하는 민아 보고싶네여ㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠ 흡 민아야 기사단 제복 입어조....")
    #                                                                                                                                            end
    # test "@user 사람들이 헐크를 보고 첨 한말이 뭐게여" do
    #                                   assert_value KoreanSentenceAnalyser.analyse_sentence("@user 사람들이 헐크를 보고 첨 한말이 뭐게여")
    #                                   end
    # test "@user 자비스 얼굴.." do
    #                      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 자비스 얼굴..")
    #                      end
    # test "@user 읽어줘요" do
    #                  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 읽어줘요")
    #                  end
    # test "잠만자도 다이어트가 된다는 사실~ 충격적이네요~ http://link.com (..)" do
    #                                                       assert_value KoreanSentenceAnalyser.analyse_sentence("잠만자도 다이어트가 된다는 사실~ 충격적이네요~ http://link.com (..)")
    #                                                       end
    # test "너능 뭐 모카사주까 모카? (옷을 벗는다)" do
    #                               assert_value KoreanSentenceAnalyser.analyse_sentence("너능 뭐 모카사주까 모카? (옷을 벗는다)")
    #                               end
    # test "@user 으아 진짜 병날것 같아요.." do
    #                             assert_value KoreanSentenceAnalyser.analyse_sentence("@user 으아 진짜 병날것 같아요..")
    #                             end
    # test "@user 병희오빠한테도 부탁해여" do
    #                          assert_value KoreanSentenceAnalyser.analyse_sentence("@user 병희오빠한테도 부탁해여")
    #                          end
    # test "@user 투표덕에 졸업한 학교도 오랜만에 가봅니다♥ 모닝투표하고 출근햇어요ㅠ http://link.com" do
    #                                                                   assert_value KoreanSentenceAnalyser.analyse_sentence("@user 투표덕에 졸업한 학교도 오랜만에 가봅니다♥ 모닝투표하고 출근햇어요ㅠ http://link.com")
    #                                                                   end
    # test "@user 심ㅁㅈㅣ어ㄱ그 겁쟁이 코우메한테ㅎㅏ는ㅅ소리" do
    #                                     assert_value KoreanSentenceAnalyser.analyse_sentence("@user 심ㅁㅈㅣ어ㄱ그 겁쟁이 코우메한테ㅎㅏ는ㅅ소리")
    #                                     end
    # test "@user 아 구래? 한번 해봐야 겠당 ㅇ0ㅇ!! 고마웡!" do
    #                                        assert_value KoreanSentenceAnalyser.analyse_sentence("@user 아 구래? 한번 해봐야 겠당 ㅇ0ㅇ!! 고마웡!")
    #                                        end
    # test "? 2시간동안 뭐햇지 ?" do
    #                     assert_value KoreanSentenceAnalyser.analyse_sentence("? 2시간동안 뭐햇지 ?")
    #                     end
    # test "케가수님의 두산이 드디어 경기를 하는군.." do
    #                               assert_value KoreanSentenceAnalyser.analyse_sentence("케가수님의 두산이 드디어 경기를 하는군..")
    #                               end
    # test "@user ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ" do
    #                                                                     assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ")
    #                                                                     end
    # test "@user 네 ㅎㅎ" do
    #                  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 네 ㅎㅎ")
    #                  end
    # test "@user 왜이래..응? *당황스레 보며 등을 쓸어준다*" do
    #                                       assert_value KoreanSentenceAnalyser.analyse_sentence("@user 왜이래..응? *당황스레 보며 등을 쓸어준다*")
    #                                       end
    # test "@user 칭찬은 언제나 감사합니다 ㄲㄲ" do
    #                              assert_value KoreanSentenceAnalyser.analyse_sentence("@user 칭찬은 언제나 감사합니다 ㄲㄲ")
    #                              end
    # test "....알티 그만 좀..." do
    #                      assert_value KoreanSentenceAnalyser.analyse_sentence("....알티 그만 좀...")
    #                      end
    # test "아 요즘 정도전보면서 기시감든다했더니 유시민이랑 타입 비슷한거같아…ㅇㅅㅇ" do
    #                                                assert_value KoreanSentenceAnalyser.analyse_sentence("아 요즘 정도전보면서 기시감든다했더니 유시민이랑 타입 비슷한거같아…ㅇㅅㅇ")
    #                                                end
    # test "@user 비행기?ㅋㅋㅋㅋ" do
    #                      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 비행기?ㅋㅋㅋㅋ")
    #                      end
    # test "@user ... 잠만보." do
    #                      assert_value KoreanSentenceAnalyser.analyse_sentence("@user ... 잠만보.")
    #                      end
    # test "@user 보관할꺼에요?" do
    #                     assert_value KoreanSentenceAnalyser.analyse_sentence("@user 보관할꺼에요?")
    #                     end
    # test "@user 우늉...냐! #업기" do
    #                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user 우늉...냐! #업기")
    #                         end
    # test "@user 어...어 아닌데... 어?????" do
    #                                 assert_value KoreanSentenceAnalyser.analyse_sentence("@user 어...어 아닌데... 어?????")
    #                                 end
    # test "@user 10평균 943인데요 ㅠㅠ" do
    #                            assert_value KoreanSentenceAnalyser.analyse_sentence("@user 10평균 943인데요 ㅠㅠ")
    #                            end
    # test "@user 시발ㄹ넘잘생겼ㅅ어" do
    #                       assert_value KoreanSentenceAnalyser.analyse_sentence("@user 시발ㄹ넘잘생겼ㅅ어")
    #                       end
    # test "풍치수려한 릉라도에 세 세기의 요구에 맞게 인민의 문화정서생활기지로 훌륭히 꾸려진 릉라인민체육공원으로 수많은 근로자들과 청소년학생들이 찾아와 즐거운 휴식의 한때를 보내고있다.  http://link.com" do
    #                                                                                                                          assert_value KoreanSentenceAnalyser.analyse_sentence("풍치수려한 릉라도에 세 세기의 요구에 맞게 인민의 문화정서생활기지로 훌륭히 꾸려진 릉라인민체육공원으로 수많은 근로자들과 청소년학생들이 찾아와 즐거운 휴식의 한때를 보내고있다.  http://link.com")
    #                                                                                                                          end
    # test "@user ㄷ올렷더" do
    #                  assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㄷ올렷더")
    #                  end
    # test "@user ..나오토..나간다고하지 않았어?" do
    #                                assert_value KoreanSentenceAnalyser.analyse_sentence("@user ..나오토..나간다고하지 않았어?")
    #                                end
    # test "@user 언제부터 제 트위터를 눈팅하셨는지는 모르지만 말입니다 ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ" do
    #                                                           assert_value KoreanSentenceAnalyser.analyse_sentence("@user 언제부터 제 트위터를 눈팅하셨는지는 모르지만 말입니다 ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ")
    #                                                           end
    # test "@user 경기도는 알아ㅋㅋㅋ서울이랑 가까워서 부럽다ㅠ" do
    #                                      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 경기도는 알아ㅋㅋㅋ서울이랑 가까워서 부럽다ㅠ")
    #                                      end
    # test "@user ㅋㅌㅊㅍㅋㅋㅋㅋ새우님더 나랑 동갑이군~&gt;ㅁ&lt; (왠지삘이왓엇다!)) 소혜오프레쥔짜이뻣늗데...ㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠ" do
    #                                                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅋㅌㅊㅍㅋㅋㅋㅋ새우님더 나랑 동갑이군~&gt;ㅁ&lt; (왠지삘이왓엇다!)) 소혜오프레쥔짜이뻣늗데...ㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠ")
    #                                                                                         end
    # test "저는 536개의 금화를 모았어요! http://link.com #android, #androidgames, #gameinsight" do
    #                                                                                assert_value KoreanSentenceAnalyser.analyse_sentence("저는 536개의 금화를 모았어요! http://link.com #android, #androidgames, #gameinsight")
    #                                                                                end
    # test "앗시... 친구 커미션 그려야 된다.. 일한다.." do
    #                                   assert_value KoreanSentenceAnalyser.analyse_sentence("앗시... 친구 커미션 그려야 된다.. 일한다..")
    #                                   end
    # test ""@user: [FANTAKEN] 140530 A Pink at Korea University Ipselenti Festival #에이핑크 :: HAYOUNG by 볼매윤보미 ^eunsa^ *5 http://link.com"" do
    #                         assert_value KoreanSentenceAnalyser.analyse_sentence(""@user: [FANTAKEN] 140530 A Pink at Korea University Ipselenti Festival #에이핑크 :: HAYOUNG by 볼매윤보미 ^eunsa^ *5 http://link.com"")
    #                                                                                                                                              end
    #                                                                                                                                              test "갑자기 포켓몬 의인화두 해보구싶다. 몇개 생각해둔게 있긴한데..ㅜㅜ" do
    #                                                                                                                                                                                           assert_value KoreanSentenceAnalyser.analyse_sentence("갑자기 포켓몬 의인화두 해보구싶다. 몇개 생각해둔게 있긴한데..ㅜㅜ")
    #                                                                                                                                                                                           end
    # test "@user ????.... 니가어디가.." do
    #                              assert_value KoreanSentenceAnalyser.analyse_sentence("@user ????.... 니가어디가..")
    #                              end
    # test "@user ....왜?." do
    #                     assert_value KoreanSentenceAnalyser.analyse_sentence("@user ....왜?.")
    #                     end
    # test "언론 플레이 돈써서 하지말고 선거도 하지말고 그냥새눌당 다하세요 국민에게 지지받았다 국민 미개인 만들지 말고ᆢ" do
    #                                                                     assert_value KoreanSentenceAnalyser.analyse_sentence("언론 플레이 돈써서 하지말고 선거도 하지말고 그냥새눌당 다하세요 국민에게 지지받았다 국민 미개인 만들지 말고ᆢ")
    #                                                                     end
    # test "@user  ㅋㅋㅋㅋㅋㅋㅋㅋ근데 저거 사막에사는거래요???ㅋㅋㅋㅋㅋㅋㅋ하나도 위협적인게없는데..굴러다닐거같이생겼" do
    #                                                                      assert_value KoreanSentenceAnalyser.analyse_sentence("@user  ㅋㅋㅋㅋㅋㅋㅋㅋ근데 저거 사막에사는거래요???ㅋㅋㅋㅋㅋㅋㅋ하나도 위협적인게없는데..굴러다닐거같이생겼")
    #                                                                      end
    # test "@user ....조금..조금 아팠던거에요." do
    #                                assert_value KoreanSentenceAnalyser.analyse_sentence("@user ....조금..조금 아팠던거에요.")
    #                                end
    # test ""@user: 나 이민혁은 무한도전의 차세대 리더 후보 기호 '나', 정형돈을 전폭지지할것을 선언합니다. 무한도전을 보장할 격식없는 후보! 가식없는 후보! 정형돈을 함께 지지해주십시오~! http://link.com" 현돈 오빠!ㅋㅋ" do
    #                                                                                                                                          assert_value KoreanSentenceAnalyser.analyse_sentence(""@user: 나 이민혁은 무한도전의 차세대 리더 후보 기호 '나', 정형돈을 전폭지지할것을 선언합니다. 무한도전을 보장할 격식없는 후보! 가식없는 후보! 정형돈을 함께 지지해주십시오~! http://link.com" 현돈 오빠!ㅋㅋ")
    #                                                                                                                                          end
    #                                                        test "@user 그럼 뒤집어 달라고 하지말던가" do
    #                                                                                      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 그럼 뒤집어 달라고 하지말던가")
    #                                                                                      end
    #                                                        test "@user 그럼.. 그 백현오빠 보여줘" do
    #                                                                                     assert_value KoreanSentenceAnalyser.analyse_sentence("@user 그럼.. 그 백현오빠 보여줘")
    #                                                                                     end
    #                                                        test "@user 다시 왔어ㅠㅡㅠ. 아이디!" do
    #                                                                                    assert_value KoreanSentenceAnalyser.analyse_sentence("@user 다시 왔어ㅠㅡㅠ. 아이디!")
    #                                                                                    end
    #                                                        test "RT @user: #플라이투더스카이 #너를너를너를 왠지 관대할 것 같은 http://link.com" do
    #                                                                                                                       assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: #플라이투더스카이 #너를너를너를 왠지 관대할 것 같은 http://link.com")
    #                                                                                                                       end
    #                                                        test "ㅇㅇ현이 괴롭힘 심해지는거 ㄸㄹㄹ... 현이가 어떻게 괴롭힐려나 또ㅜㅜ" do
    #                                                                                                       assert_value KoreanSentenceAnalyser.analyse_sentence("ㅇㅇ현이 괴롭힘 심해지는거 ㄸㄹㄹ... 현이가 어떻게 괴롭힐려나 또ㅜㅜ")
    #                                                                                                       end
    #                                                        test "아왜...승태 프로필 왜저래..죄책감들잖아ㅠㅠㅠㅠㅠㅠㅠ승태뽑으면아람이가죽는데ㅠㅠㅠ" do
    #                                                                                                             assert_value KoreanSentenceAnalyser.analyse_sentence("아왜...승태 프로필 왜저래..죄책감들잖아ㅠㅠㅠㅠㅠㅠㅠ승태뽑으면아람이가죽는데ㅠㅠㅠ")
    #                                                                                                             end
    #                                                        test "@user 글쎄. ( ͡° ͜ʖ ͡°)" do
    #                                                                                     assert_value KoreanSentenceAnalyser.analyse_sentence("@user 글쎄. ( ͡° ͜ʖ ͡°)")
    #                                                                                     end
    #                                                        test "RT @user: 아냐 이건 거짓말이야" do
    #                                                                                     assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 아냐 이건 거짓말이야")
    #                                                                                     end
    #                                                        test "RT @user: 엄마는 역시 위대하다~대한민국 엄마들 ~우리모두훌륭해여~진보교육감 화이팅!!" do
    #                                                                                                                    assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 엄마는 역시 위대하다~대한민국 엄마들 ~우리모두훌륭해여~진보교육감 화이팅!!")
    #                                                                                                                    end
    #                                                        test "[ #Tistory ][캠프 공지] 연세 영어 캠프 시작! 8/11~8/15 http://link.com" do
    #                                                                                                                          assert_value KoreanSentenceAnalyser.analyse_sentence("[ #Tistory ][캠프 공지] 연세 영어 캠프 시작! 8/11~8/15 http://link.com")
    #                                                                                                                          end
    #                                                        test "게임토르는 한국 게임 ESD 시장의 후발주자에요. H2가 심의받은 게임들을 말도 없이 그대로 갖다 파는 파렴치한 짓을 저지르고 있다만... 그래도 외국사이트에서 사는 것보다 조금은 낫겠죠...? http://link.com" do
    #                                                                                                                                                                                            assert_value KoreanSentenceAnalyser.analyse_sentence("게임토르는 한국 게임 ESD 시장의 후발주자에요. H2가 심의받은 게임들을 말도 없이 그대로 갖다 파는 파렴치한 짓을 저지르고 있다만... 그래도 외국사이트에서 사는 것보다 조금은 낫겠죠...? http://link.com")
    #                                                                                                                                                                                            end
    #                                                        test "시로 쎄쎄써하던중에 이오빠는왜 붙이냐!?" do
    #                                                                                      assert_value KoreanSentenceAnalyser.analyse_sentence("시로 쎄쎄써하던중에 이오빠는왜 붙이냐!?")
    #                                                                                      end
    #                                                        test "@user 3.넌 익명이라해도 알아볼듯 나 너시 챙길때마다 잠금화면 확인한닽ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ 어떤사진을 맘에 들어할까 존나 생각ㅋㅋㅋㅋㅋㅋㅋㅋ했어ㅎ" do
    #                                                                                                                                                       assert_value KoreanSentenceAnalyser.analyse_sentence("@user 3.넌 익명이라해도 알아볼듯 나 너시 챙길때마다 잠금화면 확인한닽ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ 어떤사진을 맘에 들어할까 존나 생각ㅋㅋㅋㅋㅋㅋㅋㅋ했어ㅎ")
    #                                                                                                                                                       end
    #                                                        test "@user 그래 기대해" do
    #                                                                            assert_value KoreanSentenceAnalyser.analyse_sentence("@user 그래 기대해")
    #                                                                            end
    #                                                        test "100% 수동봇 제보도 받아요 멘션 주심 리트윗 해드립니다." do
    #                                                                                                 assert_value KoreanSentenceAnalyser.analyse_sentence("100% 수동봇 제보도 받아요 멘션 주심 리트윗 해드립니다.")
    #                                                                                                 end
    #                                                        test "@user 응, 응, 나중에. 나중에……" do
    #                                                                                      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 응, 응, 나중에. 나중에……")
    #                                                                                      end
    #                                                        test "@user ㅋㅋㅋㅋㅋㅋ" do
    #                                                                            assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅋㅋㅋㅋㅋㅋ")
    #                                                                            end
    #                                                        test "@user 휴일엔 꼬박꼬박 쉬는 주인이 될거예요. 그냥 휴일은 아니지만." do
    #                                                                                                        assert_value KoreanSentenceAnalyser.analyse_sentence("@user 휴일엔 꼬박꼬박 쉬는 주인이 될거예요. 그냥 휴일은 아니지만.")
    #                                                                                                        end
    #                                                        test "@user 진지하게 대화? 아아...그래 날위해서 나와 너의 관계를 진지하게 생각해보겠다는 소리야? 그래 좋아.. 어서와. 나의 소중한 시체중 하나가 되어줘" do
    #                                                                                                                                                       assert_value KoreanSentenceAnalyser.analyse_sentence("@user 진지하게 대화? 아아...그래 날위해서 나와 너의 관계를 진지하게 생각해보겠다는 소리야? 그래 좋아.. 어서와. 나의 소중한 시체중 하나가 되어줘")
    #                                                                                                                                                       end
    #                                                        test "(*세상에…….*)" do
    #                                                                          assert_value KoreanSentenceAnalyser.analyse_sentence("(*세상에…….*)")
    #                                                                          end
    #                                                        test "'3층 연금' 올리기 전 '주춧돌' 놓아라 #MoneyWK http://link.com" do
    #                                                                                                                assert_value KoreanSentenceAnalyser.analyse_sentence("'3층 연금' 올리기 전 '주춧돌' 놓아라 #MoneyWK http://link.com")
    #                                                                                                                end
    #                                                        test "@user 너만봐 http://link.com" do
    #                                                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("@user 너만봐 http://link.com")
    #                                                                                         end
    #                                                        test "Mac과 Mac간의 원격접속은 정말 편하구나. 특별한 프로그램 설치가 필요없어서 더 좋음" do
    #                                                                                                                 assert_value KoreanSentenceAnalyser.analyse_sentence("Mac과 Mac간의 원격접속은 정말 편하구나. 특별한 프로그램 설치가 필요없어서 더 좋음")
    #                                                                                                                 end
    #                                                        test "킨짱 프로필 파일이 없어졌다는 소식인데요." do
    #                                                                                       assert_value KoreanSentenceAnalyser.analyse_sentence("킨짱 프로필 파일이 없어졌다는 소식인데요.")
    #                                                                                       end
    #                                                        test "@user @user @user 팀봇 있어." do
    #                                                                                        assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user @user 팀봇 있어.")
    #                                                                                        end
    #                                                        test "ㅅ아 시바 진짜로 3일연속 같은꿈을 꾼 시발 그만해" do
    #                                                                                            assert_value KoreanSentenceAnalyser.analyse_sentence("ㅅ아 시바 진짜로 3일연속 같은꿈을 꾼 시발 그만해")
    #                                                                                            end
    #                                                        test "[#타이웰컴] 푸켓 칸타리 베이 푸켓 (Kantary Bay Hotel Phuket) 최저가 검색 http://link.com" do
    #                                                                                                                                      assert_value KoreanSentenceAnalyser.analyse_sentence("[#타이웰컴] 푸켓 칸타리 베이 푸켓 (Kantary Bay Hotel Phuket) 최저가 검색 http://link.com")
    #                                                                                                                                      end
    #                                                        test "공들인 무효표 2 http://link.com" do
    #                                                                                         assert_value KoreanSentenceAnalyser.analyse_sentence("공들인 무효표 2 http://link.com")
    #                                                                                         end
    #                                                        test "A friend in need is a friend indeed." do
    #                                                                                                    assert_value KoreanSentenceAnalyser.analyse_sentence("A friend in need is a friend indeed.")
    #                                                                                                    end
    #                                                        test "RT @user `닥터 이방인` 박해진, `폭풍 오열` 열연…`소름 끼쳐` #스포츠서울닷컴 http://link.com" do
    #                                                                                                                                  assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user `닥터 이방인` 박해진, `폭풍 오열` 열연…`소름 끼쳐` #스포츠서울닷컴 http://link.com")
    #                                                                                                                                  end
    #                                                        test "@user @user 랜덤" do
    #                                                                              assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user 랜덤")
    #                                                                              end
    #                                                        test "참, RT해주시면 선팔갑니다. 빼먹고 안 적었네요." do
    #                                                                                            assert_value KoreanSentenceAnalyser.analyse_sentence("참, RT해주시면 선팔갑니다. 빼먹고 안 적었네요.")
    #                                                                                            end
    #                                                        test "RT @user: 여러분 앤캐가 생기니까 세계가 핑크빛이네요" do
    #                                                                                                 assert_value KoreanSentenceAnalyser.analyse_sentence("RT @user: 여러분 앤캐가 생기니까 세계가 핑크빛이네요")
    #                                                                                                 end
    #                                                        test "@user 10. 나만의 애기시다 하하 항상 날 ㄷ좋아해주구... 걍 다귀엳다 내 동생 삼고시프다" do
    #                                                                                                                      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 10. 나만의 애기시다 하하 항상 날 ㄷ좋아해주구... 걍 다귀엳다 내 동생 삼고시프다")
    #                                                                                                                      end
    #                                                        test "140601 백현토크: http://link.com via @user" do
    #                                                                                                      assert_value KoreanSentenceAnalyser.analyse_sentence("140601 백현토크: http://link.com via @user")
    #                                                                                                      end
    #                                                        test "@user 그래 같이 구운몽하고 행쇼...♥" do
    #                                                                                        assert_value KoreanSentenceAnalyser.analyse_sentence("@user 그래 같이 구운몽하고 행쇼...♥")
    #                                                                                        end
    #                                                        test "님들 뭘 할건진 모르겠지만 빨리해여 빨리 힐링해주고 자게.." do
    #                                                                                                 assert_value KoreanSentenceAnalyser.analyse_sentence("님들 뭘 할건진 모르겠지만 빨리해여 빨리 힐링해주고 자게..")
    #                                                                                                 end
    #                                                        test "아 엄마한테 손톱깎기 어딨댜거 물어봐야지" do
    #                                                                                      assert_value KoreanSentenceAnalyser.analyse_sentence("아 엄마한테 손톱깎기 어딨댜거 물어봐야지")
    #                                                                                      end
    #                                                        test "민중이4명ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ" do
    #                                                                                                      assert_value KoreanSentenceAnalyser.analyse_sentence("민중이4명ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ")
    #                                                                                                      end
    #                                                        test "@user ㅜㅜㅜㅜㅠ" do
    #                                                                           assert_value KoreanSentenceAnalyser.analyse_sentence("@user ㅜㅜㅜㅜㅠ")
    #                                                                           end
    #                                                        test "@user 하면되지...!!" do
    #                                                                               assert_value KoreanSentenceAnalyser.analyse_sentence("@user 하면되지...!!")
    #                                                                               end
    #                                                        test "@user 손나......." do
    #                                                                               assert_value KoreanSentenceAnalyser.analyse_sentence("@user 손나.......")
    #                                                                               end
    #                                                        test "@user 그럼영등포가자!!그리고내일애경갈수있어???" do
    #                                                                                             assert_value KoreanSentenceAnalyser.analyse_sentence("@user 그럼영등포가자!!그리고내일애경갈수있어???")
    #                                                                                             end
    #                                                        test "67마루 데려와서 에버잡고 울고 싶다!" do
    #                                                                                     assert_value KoreanSentenceAnalyser.analyse_sentence("67마루 데려와서 에버잡고 울고 싶다!")
    #                                                                                     end
    #                                                        test "@user 트친소 보고왔어요! 팔로할께연 친하게지내요!↖(^▽^)↗" do
    #                                                                                                     assert_value KoreanSentenceAnalyser.analyse_sentence("@user 트친소 보고왔어요! 팔로할께연 친하게지내요!↖(^▽^)↗")
    #                                                                                                     end
    #                                                        test "@user 그치그치~선물받았당" do
    #                                                                                assert_value KoreanSentenceAnalyser.analyse_sentence("@user 그치그치~선물받았당")
    #                                                                                end
    # test "캐릭터 소속: 킬라킬(일본만화)" do
    #                         assert_value KoreanSentenceAnalyser.analyse_sentence("캐릭터 소속: 킬라킬(일본만화)")
    #                         end
    # test "내 인상이 아주아주 세고 무서웠다면 내가 무지무지 다크한 인상이었다면" do
    #                                              assert_value KoreanSentenceAnalyser.analyse_sentence("내 인상이 아주아주 세고 무서웠다면 내가 무지무지 다크한 인상이었다면")
    #                                              end
    # test "@user 지금은인가?" do
    #                    assert_value KoreanSentenceAnalyser.analyse_sentence("@user 지금은인가?")
    #                    end
    # test "팔로 신청한거 수락 다 되면 프텍으로 잠글거예여" do
    #                                  assert_value KoreanSentenceAnalyser.analyse_sentence("팔로 신청한거 수락 다 되면 프텍으로 잠글거예여")
    #                                  end
    # test "@user 하하, 난 그대가 부른다면 정말 기꺼이 그대를 향해 뛰어올거야. 사랑하는 나의 여인, 금방 돌아오길 고대하겠어. (쪽)" do
    #                                                                                assert_value KoreanSentenceAnalyser.analyse_sentence("@user 하하, 난 그대가 부른다면 정말 기꺼이 그대를 향해 뛰어올거야. 사랑하는 나의 여인, 금방 돌아오길 고대하겠어. (쪽)")
    #                                                                                end
    # test "@user 나 있는뎅" do
    #                   assert_value KoreanSentenceAnalyser.analyse_sentence("@user 나 있는뎅")
    #                   end
    # test "@user 다 순수한 연애였어 왜그래 ㄷㄷㄷ" do
    #                                assert_value KoreanSentenceAnalyser.analyse_sentence("@user 다 순수한 연애였어 왜그래 ㄷㄷㄷ")
    #                                end
    # test "@user 네 #미소" do
    #                   assert_value KoreanSentenceAnalyser.analyse_sentence("@user 네 #미소")
    #                   end
    # test "짱기요어 &gt;&lt; http://link.com" do
    #                                     assert_value KoreanSentenceAnalyser.analyse_sentence("짱기요어 &gt;&lt; http://link.com")
    #                                     end
    # test "펭귄 물개 곰 #닮았다고들어본동물" do
    #                          assert_value KoreanSentenceAnalyser.analyse_sentence("펭귄 물개 곰 #닮았다고들어본동물")
    #                          end
    # test "@user 그런건 아무래도 좋아. (단순히 야하다거나 하는 문제가 아니었다. 심지어 페로몬조차 느껴지지 않는걸. 그저 언제부터인지 보면 볼수록 가지고 싶다는 그런 소유욕. 그래, 그렇게 표현하는편이 옳을지도 모르겠어.) 갑작스러운" do
    #                                                                                                                                        assert_value KoreanSentenceAnalyser.analyse_sentence("@user 그런건 아무래도 좋아. (단순히 야하다거나 하는 문제가 아니었다. 심지어 페로몬조차 느껴지지 않는걸. 그저 언제부터인지 보면 볼수록 가지고 싶다는 그런 소유욕. 그래, 그렇게 표현하는편이 옳을지도 모르겠어.) 갑작스러운")
    #                                                                                                                                        end
    # test "@user 간지나네^^? ㅋㅋㅋㅋㅋㅋㅋㅋㅋ왜압구정왔는데연예인업써 ㅡㅡ" do
    #                                              assert_value KoreanSentenceAnalyser.analyse_sentence("@user 간지나네^^? ㅋㅋㅋㅋㅋㅋㅋㅋㅋ왜압구정왔는데연예인업써 ㅡㅡ")
    #                                              end
    # test "엄마가 내 키보드스킨 때탄것같다그 했다." do
    #                              assert_value KoreanSentenceAnalyser.analyse_sentence("엄마가 내 키보드스킨 때탄것같다그 했다.")
    #                              end
    # test "@user 그렇다면 파시면 될 것 같습니다!!!! ㅠㅠㅠ 흐으러어그ㅠㅠㅠㅠ 닌타마 캐들이 넘 매력덩어리예여 ㅠㅠㅠㅠㅠㅠㅠ" do
    #                                                                           assert_value KoreanSentenceAnalyser.analyse_sentence("@user 그렇다면 파시면 될 것 같습니다!!!! ㅠㅠㅠ 흐으러어그ㅠㅠㅠㅠ 닌타마 캐들이 넘 매력덩어리예여 ㅠㅠㅠㅠㅠㅠㅠ")
    #                                                                           end
    # test "...사카나 씨? @user" do
    #                       assert_value KoreanSentenceAnalyser.analyse_sentence("...사카나 씨? @user")
    #                       end
    # test "@user ★★★★★★★★★★★★★★★★ 별받아" do
    #                                  assert_value KoreanSentenceAnalyser.analyse_sentence("@user ★★★★★★★★★★★★★★★★ 별받아")
    #                                  end
    # test "저는 870의 식량을 수확했어요! http://link.com #android, #androidgames, #gameinsight" do
    #                                                                                assert_value KoreanSentenceAnalyser.analyse_sentence("저는 870의 식량을 수확했어요! http://link.com #android, #androidgames, #gameinsight")
    #                                                                                end
    # test "@user 그쵸? (쇼트케이크를 한 입 먹다가 문득 푹 한숨을 쉰다.) 이런 거 먹는 것도 좀 자제해야 하나?" do
    #                                                                     assert_value KoreanSentenceAnalyser.analyse_sentence("@user 그쵸? (쇼트케이크를 한 입 먹다가 문득 푹 한숨을 쉰다.) 이런 거 먹는 것도 좀 자제해야 하나?")
    #                                                                     end
    # test "개표하러간당!!!!!!!! 개고생하고올겤ㅋㅋ" do
    #                                assert_value KoreanSentenceAnalyser.analyse_sentence("개표하러간당!!!!!!!! 개고생하고올겤ㅋㅋ")
    #                                end
    # test "@user 포기하지마!! 일어나... 재벌 일어나!!!!(존나" do
    #                                          assert_value KoreanSentenceAnalyser.analyse_sentence("@user 포기하지마!! 일어나... 재벌 일어나!!!!(존나")
    #                                          end
    # test "140508 엠카운트다운 EXO-K #종인 #카이 흑백카이는 진리입니다" do
    #                                               assert_value KoreanSentenceAnalyser.analyse_sentence("140508 엠카운트다운 EXO-K #종인 #카이 흑백카이는 진리입니다")
    #                                               end
    # test "이곳에 있는 책들은 당신 신사의 5년치 새전 정도의 가치가 있어" do
    #                                           assert_value KoreanSentenceAnalyser.analyse_sentence("이곳에 있는 책들은 당신 신사의 5년치 새전 정도의 가치가 있어")
    #                                           end
    # test "아 나니요 http://link.com" do
    #                             assert_value KoreanSentenceAnalyser.analyse_sentence("아 나니요 http://link.com")
    #                             end
    # test "@user ?? 이영싫 탈덕했어???" do
    #                            assert_value KoreanSentenceAnalyser.analyse_sentence("@user ?? 이영싫 탈덕했어???")
    #                            end
    # test "마냥 어린 아인 줄 알았는데 언제 이렇게 커서 연인이 생겼어요. 이제 과거는 잊어요. 힘들어도 이제 혼자가 아니잖아요. 이 오빠의 부탁이야. 행복해지렴. (1기/메이샬 쉘버나스)" do
    #                                                                                                           assert_value KoreanSentenceAnalyser.analyse_sentence("마냥 어린 아인 줄 알았는데 언제 이렇게 커서 연인이 생겼어요. 이제 과거는 잊어요. 힘들어도 이제 혼자가 아니잖아요. 이 오빠의 부탁이야. 행복해지렴. (1기/메이샬 쉘버나스)")
    #                                                                                                           end
    # test "[만능유희왕]버서커 소울 http://link.com (#tvple)" do
    #                                              assert_value KoreanSentenceAnalyser.analyse_sentence("[만능유희왕]버서커 소울 http://link.com (#tvple)")
    #                                              end
    # test "“@user: 우지호 잠시나마 널 의심해서 미안해.. http://link.com” @user 솔직히 짱이지" do
    #                                                                    assert_value KoreanSentenceAnalyser.analyse_sentence("“@user: 우지호 잠시나마 널 의심해서 미안해.. http://link.com” @user 솔직히 짱이지")
    #                                                                    end
    # test "@user 헐... 먹을 걸 양보하시다니..! 코레와 진정한 사랑이네요(뭐래" do
    #                                                  assert_value KoreanSentenceAnalyser.analyse_sentence("@user 헐... 먹을 걸 양보하시다니..! 코레와 진정한 사랑이네요(뭐래")
    #                                                  end
    # test "가만히 있으라해서 가만히 있는다면, 이번 피해자는 우리 자신이 될 것입니다." do
    #                                                  assert_value KoreanSentenceAnalyser.analyse_sentence("가만히 있으라해서 가만히 있는다면, 이번 피해자는 우리 자신이 될 것입니다.")
    #                                                  end
    # test "미련이 쩔게남ㅁ았나보다...아 걍 인문계가야하나" do
    #                                  assert_value KoreanSentenceAnalyser.analyse_sentence("미련이 쩔게남ㅁ았나보다...아 걍 인문계가야하나")
    #                                  end
    # test "@user @user 오따꾸 감별." do
    #                           assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user 오따꾸 감별.")
    #                           end
    # test "고튼:얘도 다리떤다...그리고 멍때린다" do
    #                             assert_value KoreanSentenceAnalyser.analyse_sentence("고튼:얘도 다리떤다...그리고 멍때린다")
    #                             end
    # test "@user 새우깡 먹고싶어" do
    #                      assert_value KoreanSentenceAnalyser.analyse_sentence("@user 새우깡 먹고싶어")
    #                      end
    # test "@user @user 아프리카깔고.." do
    #                            assert_value KoreanSentenceAnalyser.analyse_sentence("@user @user 아프리카깔고..")
    #                            end
    #  end
  end
end
