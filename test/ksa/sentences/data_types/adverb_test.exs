defmodule Sentences.DataTypes.AdverbTest do
  use ExUnit.Case
  import Ksa, only: [analyse: 1]
  alias Ksa.Structs.Adverb

  test "힐끗힐끗" do
    result = analyse("힐끗힐끗")

    assert Enum.member?(result, %Adverb{match: "힐끗힐끗", type: "adverb", word: "힐끗힐끗"})
  end
end
