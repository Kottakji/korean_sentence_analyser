defmodule EomiTest do
  use ExUnit.Case
  import AssertValue
  alias Eomi
  alias Stem
  doctest Eomi

  describe "We can remove Eomi from words - " do
    test "가능하다" do
      assert_value(Eomi.remove("가능하다") == "가능하")
    end

    test "가능되다" do
      assert_value(Eomi.remove("가능되다") == "가능되")
    end
  end

  describe "We can remove words and then stem to get different results - " do
    test "가능한다" do
      assert_value(Stem.find(Eomi.remove("가능한다")) == "가능하")
    end

    test "가능해" do
      assert_value(Stem.find(Eomi.remove("가능해")) == "가능하")
    end

    test "가능할텐데요" do
      assert_value(Stem.find(Eomi.remove("가능할텐데요")) == "가능하")
    end

    test "가능해요" do
      assert_value(Stem.find(Eomi.remove("가능해요")) == "가능하")
    end

    test "가능돼" do
      assert_value(Stem.find(Eomi.remove("가능돼")) == "가능되")
    end

    test "가능돼요" do
      assert_value(Stem.find(Eomi.remove("가능돼요")) == "가능되")
    end

    test "맛있다" do
      assert_value(Stem.find(Eomi.remove("맛있다")) == "맛있")
    end

    test "맛없다" do
      assert_value(Stem.find(Eomi.remove("맛없다")) == "맛없")
    end
  end
end
