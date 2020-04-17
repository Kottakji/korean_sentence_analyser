defmodule NounTest do
  use AssertValue
  use ExUnit.Case
  
  @tag :now
  test "서울" do
    assert_value KoreanSentenceAnalyser.analyse("서울")
  end
end