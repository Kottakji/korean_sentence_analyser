defmodule Words.DifficultWordsTest do
  use ExUnit.Case
  import Ksa
  import AssertValue

  test "채워지지" do
    assert_value analyse("채워지지") == [%{"채워지지" => "채우다"}]
  end

  test "도망치" do
    assert_value analyse("도망치") == [%{"도망치" => "도망치다"}]
  end

  test "이룩하여" do
    assert_value analyse("이룩하여") == [%{"이룩하여" => "이룩"}]
  end

  test "통하여" do
    assert_value analyse("통하여") == [%{"통하여" => "통하다"}]
  end

  test "때려눕히고" do
    assert_value analyse("때려눕히고") == [%{"때려눕히고" => "때려눕히다"}]
  end

  test "짰다" do
    assert_value analyse("짰다") == [%{"짰다" => "짜다"}]
  end

  test "직계가족에는" do
    assert_value analyse("직계가족에는") == [%{"직계가족에는" => "직계가족"}]
  end

  test "들어섰다" do
    assert_value analyse("들어섰다") == [%{"들어섰다" => "들어서다"}]
  end

  test "살아야" do
    assert_value analyse("살아야") == [%{"살아야" => "살다"}]
  end

  test "매기고" do
    assert_value analyse("매기고") == [%{"매기고" => "매기다"}]
  end

  #  무수히
  # 것이다
  # 가라앉았다
  # 타서
  # 호는
  # 가져야
  # 것이었다
  # 받지
  # 왔는가를
  # 주었다
  # 주도하였다
  # 왔다
  # 동학도
  # 받아
end
