defmodule WordTest do
  use ExUnit.Case
  import AssertValue
  
  describe "Example words - " do
  
    @tag :now
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
