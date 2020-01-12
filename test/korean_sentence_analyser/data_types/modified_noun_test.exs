defmodule ModifiedNounTest do
  use ExUnit.Case
  import AssertValue
  doctest KSA.ModifiedNoun

  describe "We can find verbs from nouns directly - " do
    test "생각한다면" do
      assert_value(
        KSA.ModifiedNoun.find("생각한다면") ==
          %{"specific_type" => "Mix", "token" => "생각하다", "type" => "Mix"}
      )
    end

    test "당했다" do
      assert_value KSA.ModifiedNoun.find("당했다") == %{"specific_type" => "Mix", "token" => "당하다", "type" => "Mix"}
    end
  end

  describe "We can find adjectives from nouns directly - " do
    # When searching on 은근길다
    test "은근길" do
      assert_value(
        KSA.ModifiedNoun.find("은근길") ==
          nil
      )
    end

    test "은근하다" do
      assert_value(
        KSA.ModifiedNoun.find("은근하다") ==
          %{"specific_type" => "Mix", "token" => "은근하다", "type" => "Mix"}
      )
    end

    test "은근히" do
      assert_value(
        KSA.ModifiedNoun.find("은근히") ==
          %{"specific_type" => "Mix", "token" => "은근히", "type" => "Mix"}
      )
    end
  end

  describe "We can find verbs from nouns - " do
    test "생각한다면" do
      assert_value(
        KoreanSentenceAnalyser.analyse_sentence("생각한다면") ==
          [%{"specific_type" => "Mix", "token" => "생각하다", "type" => "Mix"}]
      )
    end

    test "가능해" do
      assert_value(
        KoreanSentenceAnalyser.analyse_sentence("가능해") == [
          %{"specific_type" => "Mix", "token" => "가능하다", "type" => "Mix"}
        ]
      )
    end
  end

  describe "We do not match certain verbs - " do
    test "만든" do
      assert_value KSA.ModifiedNoun.find("만든") == nil
    end
  end
end
