defmodule Words.DataTypes.AuxiliaryTest do
  use ExUnit.Case
  import Ksa.DataTypes.Auxiliary, only: [match: 1]
  alias Ksa.Structs.Auxiliary

  test "이러니" do
    assert Enum.member?(
             match("이러니"),
             %Auxiliary{
               match: "이러니",
               type: "auxiliary",
               subtype: "conjunction",
               word: "이러니"
             }
           )
  end

  test "그" do
    assert Enum.member?(
             match("그"),
             %Auxiliary{
               match: "그",
               type: "auxiliary",
               subtype: "determiner",
               word: "그"
             }
           )
  end

  test "히이이익" do
    assert Enum.member?(
             match("히이이익"),
             %Auxiliary{
               match: "히이이익",
               type: "auxiliary",
               subtype: "exclamation",
               word: "히이이익"
             }
           )
  end
end
