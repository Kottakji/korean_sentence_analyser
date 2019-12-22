defmodule ModifierTest do
  use ExUnit.Case
  import AssertValue
  alias KoreanSentenceAnalyser.DataTypes.Modifier

  describe "We can remove modifiers - " do
    test "한표" do
      assert_value(Modifier.remove("한표") == "표")
    end
  end

  describe "We can find modifiers directly - " do
    test "한표" do
      assert_value Modifier.find("한표") == [
                     %{"specific_type" => "Modifier", "token" => "한", "type" => "Modifier"},
                     %{"specific_type" => "Noun", "token" => "표", "type" => "Noun"}
                   ]
    end

    test "다섯개" do
      assert_value Modifier.find("다섯개") == [
                     %{"specific_type" => "Modifier", "token" => "다섯", "type" => "Modifier"},
                     %{"specific_type" => "Noun", "token" => "개", "type" => "Noun"}
                   ]
    end
    
    test "3구" do
      assert_value Modifier.find("3구") == %{"specific_type" => "Modifier", "token" => "구", "type" => "Modifier"}
    end
    
    test "중랑구는" do
      # This is not a modifier, so should return nil
      assert_value Modifier.find("중랑구는") == nil
    end
  end

  describe "Can we find modifiers - " do
    test "한표" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("한표") == [
                     %{"specific_type" => "Modifier", "token" => "한", "type" => "Modifier"},
                     %{"specific_type" => "Noun", "token" => "표", "type" => "Noun"}
                   ]
    end

    test "다섯개" do
      assert_value KoreanSentenceAnalyser.analyse_sentence("다섯개") == [
                     %{"specific_type" => "Modifier", "token" => "다섯", "type" => "Modifier"},
                     %{"specific_type" => "Noun", "token" => "개", "type" => "Noun"}
                   ]
    end

    test "3구" do
      # Improvement: find this as a modifier?
      # Do we mind if it's not correctly found? Can we even?
      assert_value KoreanSentenceAnalyser.analyse_sentence("3구") == [
                     %{"specific_type" => "Family name", "token" => "구", "type" => "Substantive"}
                   ]
    end

  end
end
