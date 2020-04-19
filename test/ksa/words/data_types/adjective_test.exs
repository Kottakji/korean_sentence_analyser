defmodule Words.DataTypes.AdjectiveTest do
  use ExUnit.Case
  import Ksa
  alias Ksa.Structs.Adjective

  test "가능하" do
    assert Enum.member?(analyse("가능하"), %Adjective{word: "가능하", part: "가능하", type: "adjective"})
  end
  
  test "커요" do
    assert Enum.member?(analyse("커요"), %Adjective{word: "커요", part: "크", type: "adjective"})
  end

  test "평형해요" do
    assert Enum.member?(analyse("평형해요"), %Adjective{word: "평형해요", part: "평형하", type: "adjective"})
  end

#평형하
#평화롭
#평화스럽
#푸르
#퍼렇
#특별나
#크
end
