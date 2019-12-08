defmodule KoreanSentenceAnalyserTest do
  use ExUnit.Case
  #  doctest KoreanSentenceAnalyser
  #  import AssertValue
  #  describe "Sentences can be analysed" do
  #    test "저는 한국어를 공부하고 있어요" do
  #      assert_value KoreanSentenceAnalyser.analyse_sentence("저는 한국어를 공부하고 있어요") ==
  #                     %{
  #                       "tokens" => [
  #                         %{"token" => "저", "type" => "Noun"},
  #                         %{"token" => "는", "type" => "Josa"},
  #                         %{"token" => "한국어", "type" => "Noun"},
  #                         %{"token" => "를", "type" => "Josa"},
  #                         %{"token" => "공부", "type" => "Noun"},
  #                         %{"token" => "하고", "type" => "Josa"},
  #                         %{"token" => "있다", "type" => "Adjective"}
  #                       ]
  #                     }
  #    end
  #
  #    test "한국어 배우기가 재미있어용" do
  #      assert_value KoreanSentenceAnalyser.analyse_sentence("한국어 배우기가 재미있어용") == %{
  #                     "tokens" => [
  #                       %{"token" => "한국어", "type" => "Noun"},
  #                       %{"token" => "배우다", "type" => "Verb"},
  #                       %{"token" => "재미있다", "type" => "Adjective"}
  #                     ]
  #                   }
  #    end
  #
  #    test "Wrong input" do
  #      assert_value KoreanSentenceAnalyser.analyse_sentence("Omg") == %{
  #                     "tokens" => [%{"token" => "Omg", "type" => "Alpha"}]
  #                   }
  #    end
  #
  #    test "Empty input" do
  #      assert_value KoreanSentenceAnalyser.analyse_sentence("") == nil
  #    end
  #  end
  #
  #  describe "Words can be analysed" do
  #    test "어려워" do
  #      assert_value KoreanSentenceAnalyser.get_the_stem_of_a_word("어려워") == "어렵다"
  #    end
  #
  #    test "미치겠네" do
  #      assert_value KoreanSentenceAnalyser.get_the_stem_of_a_word("미치겠네") == "미치다"
  #    end
  #
  #    test "한자ㅋ" do
  #      assert_value KoreanSentenceAnalyser.get_the_stem_of_a_word("한자ㅋ") == "한자"
  #    end
  #
  #    test "Wrong input" do
  #      assert_value KoreanSentenceAnalyser.get_the_stem_of_a_word("Omg") == "Omg"
  #    end
  #
  #    test "Empty input" do
  #      assert_value KoreanSentenceAnalyser.get_the_stem_of_a_word("") == nil
  #    end
  #  end
end
