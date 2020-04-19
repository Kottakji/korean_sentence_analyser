defmodule Sentences.DataTypes.NounTest do
  use ExUnit.Case
  import Ksa.DataTypes.Noun, only: [match: 1]
  alias Ksa.Structs.Noun

  test "내 고향은 서울입니다" do
    result = match("내 고향은 서울입니다")

    assert Enum.member?(result, %Noun{match: "내", word: "내", type: "noun", subtype: "noun"})
    assert Enum.member?(result, %Noun{match: "고향", word: "고향은", type: "noun", subtype: "noun"})
    assert Enum.member?(result, %Noun{match: "서울", word: "서울입니다", type: "noun", subtype: "noun"})
  end

  test "서울시장에 갑시다" do
    result = match("서울시장에 갑시다")

    assert Enum.member?(result, %Noun{match: "서울", word: "서울시장에", type: "noun", subtype: "noun"})
    assert Enum.member?(result, %Noun{match: "시장", word: "서울시장에", type: "noun", subtype: "noun"})
  end
end
