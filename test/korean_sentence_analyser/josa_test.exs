defmodule JosaTest do
  use ExUnit.Case
  import AssertValue
  import KoreanSentenceAnalyser.Josa
  
  describe "We can remove Josa's from the end of words - " do
    test "밥의" do
      assert_value(remove("밥의") == "밥")
    end

    test "당신의" do
      assert_value(remove("당신의") == "당신")
    end
  end
end
