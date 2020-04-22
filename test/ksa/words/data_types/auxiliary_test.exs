defmodule Words.DataTypes.VerbTest do
  use ExUnit.Case
  import Ksa.DataTypes.Verb, only: [match: 1]
  alias Ksa.Structs.Verb

  test "만지지마" do
    assert Enum.member?(
             match("만지지마"),
             %Verb{
               conjugated: nil,
               match: "만지",
               type: "verb",
               word: "만지지마"
             }
           )
  end
end
