defmodule SuffixTest do
  use ExUnit.Case
  import AssertValue

  describe "We can match certain suffix patterns - " do
    test "년째" do
      assert_value KSA.Suffix.find("년째") == [
                     %{"specific_type" => "Noun", "token" => "년", "type" => "Noun"},
                     %{"specific_type" => "Suffix", "token" => "째", "type" => "Suffix"}
                   ]
    end
  end
end
