defmodule DeterminerTest do
  use ExUnit.Case
  import AssertValue
  alias Determiner
  doctest Determiner

  describe "We can find determiners - " do
    test "나" do
      assert_value(KoreanSentenceAnalyser.analyse_sentence("나") == [%{"specific_type" => "Determiner", "token" => "나", "type" => "Determiner"}])
    end

    test "그" do
      assert_value(KoreanSentenceAnalyser.analyse_sentence("그") == [%{"specific_type" => "Determiner", "token" => "그", "type" => "Determiner"}])
    end

    test "내가" do
      assert_value(KoreanSentenceAnalyser.analyse_sentence("내가") == [%{"specific_type" => "Determiner", "token" => "내", "type" => "Determiner"}])
    end

    test "이말" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("이말") == [
                     %{"specific_type" => "Determiner", "token" => "이", "type" => "Determiner"},
                     %{"specific_type" => "Noun", "token" => "말", "type" => "Noun"}
                   ]
    end
  end


  describe "We can remove determiners -" do
    test "이말" do
      assert_value Determiner.remove("이말") == "말"
    end
  end
end
