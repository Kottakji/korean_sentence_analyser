defmodule Words.DataTypes.AdverbTest do
  use ExUnit.Case
  import Ksa.DataTypes.Adverb, only: [match: 1]
  alias Ksa.Structs.Adverb

  test "힐끗힐끗" do
    assert Enum.member?(
             match("힐끗힐끗"),
             %Adverb{
               match: "힐끗힐끗",
               type: "adverb",
               word: "힐끗힐끗"
             }
           )
  end
end
