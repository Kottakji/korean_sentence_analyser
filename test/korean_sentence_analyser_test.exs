defmodule KoreanSentenceAnalyserTest do
  use ExUnit.Case
  doctest KoreanSentenceAnalyser
  import AssertValue

  describe "Sentences can be analysed" do
    test "저는 한국어를 공부하고 있어요" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("저는 한국어를 공부하고 있어요") ==
                     %{
                       "tokens" => [
                         %{
                           "end_offset" => 6,
                           "position" => 0,
                           "start_offset" => 3,
                           "token" => "한국어",
                           "type" => "Noun"
                         },
                         %{
                           "end_offset" => 10,
                           "position" => 1,
                           "start_offset" => 8,
                           "token" => "공부",
                           "type" => "Noun"
                         },
                         %{
                           "end_offset" => 16,
                           "position" => 2,
                           "start_offset" => 13,
                           "token" => "있다",
                           "type" => "Adjective"
                         }
                       ]
                     }
    end

    test "Wrong input" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("Omg") == %{
                     "tokens" => [
                       %{
                         "end_offset" => 3,
                         "position" => 0,
                         "start_offset" => 0,
                         "token" => "omg",
                         "type" => "Alpha"
                       }
                     ]
                   }
    end
    test "Empty input" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("") == nil
    end
  end

  describe "Words can be analysed" do
    test "어려워" do
      assert_value KoreanSentenceAnalyser.get_the_stem_of_a_word("어려워") == "어렵다"
    end

    test "미치겠네" do
      assert_value KoreanSentenceAnalyser.get_the_stem_of_a_word("미치겠네") == "미치다"
    end

    test "한자ㅋ" do
      assert_value KoreanSentenceAnalyser.get_the_stem_of_a_word("한자ㅋ") == "한자"
    end

    test "Wrong input" do
      assert_value KoreanSentenceAnalyser.get_the_stem_of_a_word("Omg") == "omg"
    end

    test "Empty input" do
      assert_value KoreanSentenceAnalyser.get_the_stem_of_a_word("") == nil
    end
  end

end