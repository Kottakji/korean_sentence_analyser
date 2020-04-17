defmodule Support.StringHelperTest do
  use ExUnit.Case
  import AssertValue
  alias KSA.Support.StringHelper
  
  test "We can split a string into all possible words" do
    # Good enough for now
    assert_value StringHelper.split("서울시장") == ["서", "서울", "서울시", "서울시장"]
  end
end