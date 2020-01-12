defmodule WordTest do
  use ExUnit.Case
  import AssertValue

  describe "Example words - " do
    test "사과" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("사과") == [%{"specific_type" => "Noun", "token" => "사과", "type" => "Noun"}]
    end

    test "만드는" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("만드는") == [%{"specific_type" => "Verb", "token" => "만들다", "type" => "Verb"}]
    end

    test "만든" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("만든") == [%{"specific_type" => "Verb", "token" => "만들다", "type" => "Verb"}]
    end

    test "싫어하지만" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("싫어하지만") == [
                     %{"specific_type" => "Adjective", "token" => "싫다", "type" => "Adjective"},
                     %{"specific_type" => "Conjunction", "token" => "하지만", "type" => "Conjunction"}
                   ]
    end

    test "주말에만" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("주말에만") == [
                     %{"specific_type" => "Noun", "token" => "주말", "type" => "Noun"},
                     %{"specific_type" => "Grammar", "token" => "에", "type" => "Grammar"},
                     %{"specific_type" => "Grammar", "token" => "만", "type" => "Grammar"}
                   ]
    end

    test "안내합니다" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("안내합니다") == [
                     %{"specific_type" => "Mix", "token" => "안내하다", "type" => "Mix"}
                   ]
    end

    test "질문방" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("질문방") == [
                     %{"specific_type" => "Wikipedia title noun", "token" => "질문방", "type" => "Noun"}
                   ]
    end

    test "교환해봐요" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("교환해봐요") == [
                     %{"specific_type" => "Mix", "token" => "교환하다", "type" => "Mix"}
                   ]
    end

    test "이용하여" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("이용하여") == [
                     %{"specific_type" => "Mix", "token" => "이용하다", "type" => "Mix"}
                   ]
    end

    test "분들과" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("분들과") == [
                     %{"specific_type" => "Noun", "token" => "분", "type" => "Noun"},
                     %{"specific_type" => "Grammar", "token" => "들", "type" => "Grammar"},
                     %{"specific_type" => "Grammar", "token" => "과", "type" => "Grammar"}
                   ]
    end

    test "밥과" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("밥과") == [
                     %{"specific_type" => "Noun", "token" => "밥", "type" => "Noun"},
                     %{"specific_type" => "Grammar", "token" => "과", "type" => "Grammar"}
                   ]
    end

    test "개와" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("개와") == [
                     %{"specific_type" => "Noun", "token" => "개", "type" => "Noun"},
                     %{"specific_type" => "Grammar", "token" => "와", "type" => "Grammar"}
                   ]
    end

    test "탈퇴했었으나" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("탈퇴했었으나") == [
                     %{"specific_type" => "Mix", "token" => "탈퇴하다", "type" => "Mix"}
                   ]
    end

    test "농림어업" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("농림어업") == [
                     %{"specific_type" => "Wikipedia title noun", "token" => "농림", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "어업", "type" => "Noun"}
                   ]
    end

    test "보류되었다" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("보류되었다") == [
                     %{"specific_type" => "Mix", "token" => "보류되다", "type" => "Mix"}
                   ]
    end

    test "지역내" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("지역") == [
                     %{"specific_type" => "Noun", "token" => "지역", "type" => "Noun"}
                   ]

      assert_value KoreanSentenceAnalyser.analyse_sentence("지역내") == [
                     %{"specific_type" => "Noun", "token" => "지역", "type" => "Noun"},
                     %{"specific_type" => "Grammar", "token" => "내", "type" => "Grammar"}
                   ]
    end

    test "대단하다고" do
      # Should be a verb
      assert_value KoreanSentenceAnalyser.analyse_sentence("대단하다고") == [
                     %{"specific_type" => "Adjective", "token" => "대단하다", "type" => "Adjective"}
                   ]
    end

    test "달한다" do
      # Should be a verb
      assert_value KoreanSentenceAnalyser.analyse_sentence("달한다") == [
                     %{"specific_type" => "Mix", "token" => "달하다", "type" => "Mix"}
                   ]
    end

    test "승격하였고" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("승격하였고") == [
                     %{"specific_type" => "Mix", "token" => "승격하다", "type" => "Mix"}
                   ]
    end

    test "중동부에" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("중동부에") == [
                     %{"specific_type" => "Wikipedia title noun", "token" => "중동", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "부", "type" => "Noun"},
                     %{"specific_type" => "Grammar", "token" => "에", "type" => "Grammar"}
                   ]
    end
  end
end
