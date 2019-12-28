defmodule JosaTest do
  use ExUnit.Case
  import AssertValue
  alias Josa
  doctest Josa

  describe "We can remove Josa's from the end of words - " do
    test "밥의" do
      assert_value(Josa.remove("밥의") == "밥")
    end

    test "당신의" do
      assert_value(Josa.remove("당신의") == "당신")
    end

    test "냐 is just a josa, so should return itself, instead of an empty string" do
      assert_value(Josa.remove("냐") == "냐")
    end
  end
end
