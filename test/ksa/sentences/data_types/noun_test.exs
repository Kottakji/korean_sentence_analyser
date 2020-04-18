defmodule Sentences.DataTypes.NounTest do
  use ExUnit.Case
  import Ksa
  alias Ksa.Structs.Noun

  test "내 고향은 서울입니다" do
    result = analyse("내 고향은 서울입니다")

    assert Enum.member?(result, %Noun{part: "내", word: "내", type: "noun", subtype: "noun"})
    assert Enum.member?(result, %Noun{part: "고향", word: "고향은", type: "noun", subtype: "noun"})
    assert Enum.member?(result, %Noun{part: "서울", word: "서울입니다", type: "noun", subtype: "noun"})
  end

  test "서울시장에 갑시다" do
    result = analyse("서울시장에 갑시다")

    assert Enum.member?(result, %Noun{part: "서울", word: "서울시장에", type: "noun", subtype: "noun"})
    assert Enum.member?(result, %Noun{part: "시장", word: "서울시장에", type: "noun", subtype: "noun"})
  end
end
