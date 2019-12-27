defmodule DeterminerTest do
  use ExUnit.Case
  import AssertValue

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
  end
end
