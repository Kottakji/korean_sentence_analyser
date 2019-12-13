defmodule ModifierTest do
  use ExUnit.Case
  import AssertValue
  import KoreanSentenceAnalyser.DataTypes.Modifier

  describe "We can remove modifiers - " do
    test "한표" do
      assert_value(remove("한표") == "표")
    end
  end
end
