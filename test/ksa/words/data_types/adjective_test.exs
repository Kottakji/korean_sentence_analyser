defmodule Words.DataTypes.AdjectiveTest do
  use ExUnit.Case
  import Ksa.DataTypes.Adjective, only: [match: 1]
  alias Ksa.Structs.Adjective
  alias Ksa.Structs.Conjugated

  test "가능하" do
    assert Enum.member?(match("가능하"), %Adjective{word: "가능하", match: "가능하", type: "adjective", conjugated: nil})

    assert Enum.member?(
             match("가능함"),
             %Adjective{
               word: "가능함",
               match: "가능하",
               type: "adjective",
               conjugated: %Conjugated{
                 conjugated: "가능하",
                 sub_type: "regular",
                 tense: "nominal",
                 type: "conjugated",
                 word: "가능함"
               }
             }
           )
  end

  test "커요" do
    assert Enum.member?(
             match("커요"),
             %Adjective{
               word: "커요",
               match: "크",
               type: "adjective",
               conjugated: %Conjugated{
                 conjugated: "크",
                 sub_type: "regular",
                 tense: "present",
                 type: "conjugated",
                 word: "커"
               }
             }
           )
  end

  test "평형해요" do
    assert Enum.member?(
             match("평형해요"),
             %Adjective{
               conjugated: %Conjugated{
                 conjugated: "평형하",
                 sub_type: "regular",
                 tense: "present",
                 type: "conjugated",
                 word: "평형해"
               },
               match: "평형하",
               type: "adjective",
               word: "평형해요"
             }
           )
  end
end
