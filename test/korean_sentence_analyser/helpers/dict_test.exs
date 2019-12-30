defmodule DictTest do
  use ExUnit.Case
  import AssertValue
  alias LocalDict

  describe "We can find words in the dictionary - " do
    test "고디모아젤" do
      assert_value LocalDict.find_in_file("고디모아젤", "noun/pokemon.txt") == "고디모아젤"
    end
  end

  describe "We can find a word starting with - " do
    test "한국대사관" do
      assert_value LocalDict.find_beginning_in_file("한국대사관", "noun/nouns.txt") == "한국"
    end

    test "연합안전보장이사회" do
      assert_value LocalDict.find_beginning_in_file("연합안전보장이사회", "noun/nouns.txt") == "연합"
    end

    test "한국아아앙국제선" do
      assert_value LocalDict.find_beginning_in_file("한국아아앙국제선", "noun/nouns.txt") == "한국"
    end
  end

  describe "We can find a word ending with - " do
    test "한국대사관" do
      assert_value LocalDict.find_ending_in_file("한국대사관", "noun/nouns.txt") == "대사관"
    end

    test "한국아아앙국제선" do
      assert_value LocalDict.find_ending_in_file("한국아아앙국제선", "noun/nouns.txt") == "국제선"
    end
  end

  describe "We can find the smallest ending with -" do
    test "아니다" do
      assert_value LocalDict.find_smallest_ending_in_file("아니다", "verb/eomi.txt") == "다"
    end
  end
end
