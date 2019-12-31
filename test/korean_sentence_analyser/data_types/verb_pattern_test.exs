defmodule VerbPatternTest do
  use ExUnit.Case
  import AssertValue
  doctest KSA.VerbPattern

  describe "We can remove certain verb patters - " do
    test "마실 수 있다" do
      assert_value KSA.VerbPattern.remove(["마실", "수", "있다"]) == ["마시"]
    end

    test "먹을 수 있다" do
      assert_value KSA.VerbPattern.remove(["먹을", "수", "있다"]) == ["먹"]
    end

    test "수 있다" do
      assert_value KSA.VerbPattern.remove(["수", "있다"]) == ["수", "있다"]
    end

    test "할 수" do
      assert_value KSA.VerbPattern.remove(["할", "수"]) == ["할", "수"]
    end

    test "한다" do
      assert_value KSA.VerbPattern.remove(["한다"]) == ["하다"]
    end

    test "말한다" do
      assert_value KSA.VerbPattern.remove(["말한다"]) == ["말하다"]
    end
  end
end
