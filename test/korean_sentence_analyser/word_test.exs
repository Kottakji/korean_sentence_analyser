defmodule WordTest do
  use ExUnit.Case
  import AssertValue

  describe "Example words - " do
    test "밥과" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("밥과") == [%{"specific_type" => "Noun", "token" => "밥", "type" => "Noun"}]
    end

    test "개와" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("개와") == [%{"specific_type" => "Noun", "token" => "개", "type" => "Noun"}]
    end
    
    test "탈퇴했었으나" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("탈퇴했었으나") == [%{"specific_type" => "Mix", "token" => "탈퇴하다", "type" => "Mix"}]
    end

    test "농림어업" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("농림어업") == [
                     %{"specific_type" => "Wikipedia title noun", "token" => "농림", "type" => "Noun"},
                     %{"specific_type" => "Noun", "token" => "어업", "type" => "Noun"}
                   ]
    end

    test "보류되었다" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("보류되었다") == [%{"specific_type" => "Mix", "token" => "보류되다", "type" => "Mix"}]
    end

    test "지역내" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("지역") == [
                     %{"specific_type" => "Noun", "token" => "지역", "type" => "Noun"}
                   ]

      assert_value KoreanSentenceAnalyser.analyse_sentence("지역내") == [
                     %{"specific_type" => "Noun", "token" => "지역", "type" => "Noun"},
                     %{"specific_type" => "grammar", "token" => "내", "type" => "grammar"}
                   ]
    end

    test "대단하다고" do
      # Should be a verb
      assert_value KoreanSentenceAnalyser.analyse_sentence("대단하다고") == [%{"specific_type" => "Adjective", "token" => "대단하다", "type" => "Adjective"}]
    end

    test "달한다" do
      # Should be a verb
      assert_value KoreanSentenceAnalyser.analyse_sentence("달한다") == [
                     %{"specific_type" => "Verb", "token" => "달하다", "type" => "Verb"}
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
                     %{"specific_type" => "Noun", "token" => "부", "type" => "Noun"}
                   ]
    end
  end
end
