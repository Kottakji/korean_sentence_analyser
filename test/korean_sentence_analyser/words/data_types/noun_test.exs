defmodule Words.DataTypes.NounTest do
  use ExUnit.Case
  import KoreanSentenceAnalyser
  alias KSA.Structs.Noun
  
  test "서울" do
    assert Enum.member?(analyse("서울"), %Noun{accuracy: 100, type: "noun", word: "서울"})
  end

  test "숲" do
    assert Enum.member?(analyse("숲"), %Noun{accuracy: 60, type: "noun", word: "숲"})
  end
end