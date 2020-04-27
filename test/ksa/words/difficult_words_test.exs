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

  test "저는" do
    assert_value analyse("저는") == [%{"저는" => "저"}]
  end

  test "했어요" do
    assert_value analyse("했어요") == [%{"했어요" => "하다"}]
  end

  test "저는 공부하느라고 청소를 못 했어요" do
    assert_value analyse("저는 공부하느라고 청소를 못 했어요") == [
                   %{"공부하느라고" => "공부"},
                   %{"못" => "못"},
                   %{"저는" => "저"},
                   %{"청소를" => "청소"},
                   %{"했어요" => "하다"}
                 ]
  end

  test "무수히" do
    assert_value analyse("무수히") == [%{"무수히" => "무수히"}]
  end

  test "것이다" do
    assert_value analyse("것이다") == [%{"것이다" => "것"}]
  end

  test "가라앉았다" do
    assert_value analyse("가라앉았다") == [%{"가라앉았다" => "가라앉다"}]
  end

  test "타서" do
    assert_value analyse("타서") == [%{"타서" => "타다"}]
  end

  test "받지" do
    assert_value analyse("받지") == [%{"받지" => "받다"}]
  end

  test "것이었다" do
    assert_value analyse("것이었다") == [%{"것이었다" => "것"}]
  end

  @tag :now
  test "not" do
    assert_value analyse("not") == []
  end
  #    test "가져야" do
  #      assert_value analyse_verbose("가져야")
  #    end

  #  test "왔는가를" do
  #    assert_value analyse_verbose("왔는가를")
  #  end
  #  test "" do
  #    assert_value analyse("")
  #  end

  # 가져야
  #
  # 받지
  # 왔는가를
  # 주었다
  # 주도하였다
  # 왔다
  # 동학도
  # 받아
end
