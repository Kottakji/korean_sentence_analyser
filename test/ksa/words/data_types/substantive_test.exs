defmodule Words.DataTypes.SubstantiveTest do
  use ExUnit.Case
  import Ksa.DataTypes.Substantive, only: [match: 1]
  alias Ksa.Structs.Substantive

  test "그냥" do
    assert Enum.member?(
             match("그냥"),
             %Substantive{
               match: "그냥",
               type: "substantive",
               subtype: "modifier",
               word: "그냥"
             }
           )
  end

  test "누나" do
    # Needs to be a suffix
    assert match("누나") == []
  end

  test "김누나" do
    assert Enum.member?(
             match("김누나"),
             %Substantive{
               match: "누나",
               type: "substantive",
               subtype: "suffix",
               word: "김누나"
             }
           )
  end

  test "박미경" do
    assert Enum.member?(
             match("박미경"),
             %Substantive{
               match: "박미경",
               type: "substantive",
               subtype: "name",
               word: "박미경"
             }
           )
  end
end
