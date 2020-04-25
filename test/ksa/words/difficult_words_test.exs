defmodule Words.DifficultWordsTest do
  use ExUnit.Case
  import Ksa, only: [analyse: 1, analyse: 2]
  import Ksa.Analyse, only: [rate: 1]
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
end
