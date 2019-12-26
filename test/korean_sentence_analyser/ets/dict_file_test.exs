defmodule DictFileTest do
  use ExUnit.Case
  import AssertValue
  alias KoreanSentenceAnalyser.ETS.DictFile

  describe "We can find values in the dictionaries - " do
    test "화염레오" do
      assert_value DictFile.find("화염레오", "data/noun/pokemon.txt") == "화염레오"
    end

    test "When we find nothing" do
      assert_value DictFile.find("blabla", "data/noun/pokemon.txt") == nil
    end

    test "When we give an empty string, it should give us nil" do
      assert_value DictFile.find("", "data/noun/pokemon.txt") == nil
    end
  end
end
