defmodule WikipediaTextTest do
  use ExUnit.Case
  import AssertValue
  
  describe "Wikipedia text -" do
    test "음식(飮食) 또는 먹을거리는 먹거나 마실 수 있는 모든 것을 가리키는 말로 요리를 통해 만들기도 한다" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("음식(飮食) 또는 먹을거리는 먹거나 마실 수 있는 모든 것을 가리키는 말로 요리를 통해 만들기도 한다") == [
                     %{"specific_type" => "Noun", "token" => "음식", "type" => "Noun"},
                     %{"specific_type" => "Adverb", "token" => "또는", "type" => "Adverb"},
                     %{"specific_type" => "Verb", "token" => "먹다", "type" => "Verb"},
                     %{"specific_type" => "Verb", "token" => "마시다", "type" => "Verb"},
                     %{"specific_type" => "Noun", "token" => "모든", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "것", "type" => "Noun"},
                     %{"specific_type" => "Verb", "token" => "가리키다", "type" => "Verb"},
                     %{"specific_type" => "Noun", "token" => "말로", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "요리", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "통해", "type" => "Noun"},
                     %{"specific_type" => "Verb", "token" => "만들다", "type" => "Verb"},
                     %{"specific_type" => "Verb", "token" => "하다", "type" => "Verb"}
                   ]
    end
    
    test "대부분의 음식은 일부를 제외하고는 모두 식물이나 동물에서 얻을 수 있다" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("대부분의 음식은 일부를 제외하고는 모두 식물이나 동물에서 얻을 수 있다") == [
                     %{"specific_type" => "Noun", "token" => "대부분", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "음식", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "일부", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "제외", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "모두", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "식물", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "동물", "type" => "Noun"},
                     %{"specific_type" => "Verb", "token" => "얻다", "type" => "Verb"}
                   ]
    end
    
    test "동물(動物) 또는 뭍사리는[1] 동물계(動物界, Animalia)로 분류되는 생물의 총칭이다." do
      assert_value KoreanSentenceAnalyser.analyse_sentence("동물(動物) 또는 뭍사리는[1] 동물계(動物界, Animalia)로 분류되는 생물의 총칭이다.") == [
                     %{"specific_type" => "Noun", "token" => "동물", "type" => "Noun"},
                     %{"specific_type" => "Adverb", "token" => "또는", "type" => "Adverb"},
                     %{"specific_type" => "Noun", "token" => "뭍", "type" => "Noun"},
                     %{"specific_type" => "Verb", "token" => "사리다", "type" => "Verb"},
                     %{"specific_type" => "Wikipedia title noun", "token" => "동물계", "type" => "Noun"},
                     %{"specific_type" => "Family name", "token" => "로", "type" => "Substantive"},
                     %{"specific_type" => "Mix", "token" => "분류되", "type" => "Mix"},
                     %{"specific_type" => "Noun", "token" => "생물", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "총칭", "type" => "Noun"}
                   ]
    end
    
    test "그는 스승 플라톤이 관념론적 이상주의임에 대하여 경험론적 현실주의자로 지적되고 있으며, 예술에 관해서도 플라톤과 다른 의견을 내세우고 있다" do
      # Improvement: remove 대해/대한
      assert_value KoreanSentenceAnalyser.analyse_sentence("그는 스승 플라톤이 관념론적 이상주의임에 대하여 경험론적 현실주의자로 지적되고 있으며, 예술에 관해서도 플라톤과 다른 의견을 내세우고 있다") == [
                     %{"specific_type" => "Determiner", "token" => "그", "type" => "Determiner"},
                     %{"specific_type" => "Noun", "token" => "스승", "type" => "Noun"},
                     %{"specific_type" => "Wikipedia title noun", "token" => "플라톤", "type" => "Noun"},
                     %{"specific_type" => "Wikipedia title noun", "token" => "관념론", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "적", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "이상주의", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "임", "type" => "Noun"},
                     %{"specific_type" => "Verb", "token" => "대다", "type" => "Verb"},
                     %{"specific_type" => "Wikipedia title noun", "token" => "경험론", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "현실", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "주의자", "type" => "Noun"},
                     %{"specific_type" => "Family name", "token" => "로", "type" => "Substantive"},
                     %{"specific_type" => "Mix", "token" => "지적되", "type" => "Mix"},
                     %{"specific_type" => "Adjective", "token" => "있다", "type" => "Adjective"},
                     %{"specific_type" => "Noun", "token" => "예술", "type" => "Noun"},
                     %{"specific_type" => "Mix", "token" => "관하다", "type" => "Mix"},
                     %{"specific_type" => "Noun", "token" => "다른", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "의견", "type" => "Noun"},
                     %{"specific_type" => "Verb", "token" => "내다", "type" => "Verb"}
                   ]
    end

    test "철학자(哲學者)는 넓은 의미에서 철학을 연구하는 사람을 말한다" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("철학자(哲學者)는 넓은 의미에서 철학을 연구하는 사람을 말한다") == [
                     %{"specific_type" => "Noun", "token" => "철학자", "type" => "Noun"},
                     %{"specific_type" => "Adjective", "token" => "넓다", "type" => "Adjective"},
                     %{"specific_type" => "Noun", "token" => "의미", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "철학", "type" => "Noun"},
                     %{"specific_type" => "Mix", "token" => "연구하다", "type" => "Mix"},
                     %{"specific_type" => "Noun", "token" => "사람", "type" => "Noun"},
                     %{"specific_type" => "Verb", "token" => "말하다", "type" => "Verb"}
                   ]
    end
  end
end
