defmodule GrammarTest do
  use ExUnit.Case
  import AssertValue
  doctest KSA.Grammar

  describe "We can remove certain verb patters - " do
    test "마실 수도 있다" do
      assert_value KSA.Grammar.remove(["마실", "수도", "있다"]) == ["마시"]
    end
    test "마실 수 있다" do
      assert_value KSA.Grammar.remove(["마실", "수", "있다"]) == ["마시"]
    end

    test "먹을 수 있다" do
      assert_value KSA.Grammar.remove(["먹을", "수", "있다"]) == ["먹"]
    end

    test "수 있다" do
      assert_value KSA.Grammar.remove(["수", "있다"]) == ["수", "있다"]
    end

    test "할 수" do
      assert_value KSA.Grammar.remove(["할", "수"]) == ["할", "수"]
    end

    test "한다" do
      assert_value KSA.Grammar.remove(["한다"]) == ["하"]
    end

    test "말한다" do
      assert_value KSA.Grammar.remove(["말한다"]) == ["말하"]
    end
  end
end
