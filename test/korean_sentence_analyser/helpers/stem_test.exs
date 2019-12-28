defmodule StemTest do
  use ExUnit.Case
  import AssertValue
  alias Stem
  doctest Stem

  # Note that we are trying to recreate the stem
  # So the input here is after we removed the eomi
  # So instead of 냈다, the input would be 냈, and output should be 내다
  describe "We can trace back the stem of words - " do
    test "한" do
      assert_value(Stem.find("한") == "하")
    end

    test "할" do
      assert_value(Stem.find("할") == "하")
    end

    test "했" do
      assert_value(Stem.find("했") == "하")
    end

    test "냈다" do
      assert_value(Stem.find("냈") == "내")
    end

    test "넣었어" do
      assert_value(Stem.find("넣었") == "넣")
    end

    test "남았어" do
      assert_value(Stem.find("남았") == "남")
    end

    test "해" do
      assert_value(Stem.find("해") == "하")
    end

    test "돼" do
      assert_value(Stem.find("돼") == "되")
    end

    test "있었" do
      assert_value(Stem.find("있었") == "있")
    end

    test "있을" do
      assert_value(Stem.find("있을") == "있")
    end
  end
end
