defmodule Sentences.DataTypes.NounTest do
  use ExUnit.Case
  import KoreanSentenceAnalyser
  
  test "내 고향은 서울입니다" do
    result = analyse("내 고향은 서울입니다")
    
    assert Enum.member?(result, %KSA.Structs.Noun{accuracy: 60, type: "noun", word: "내"})
    assert Enum.member?(result, %KSA.Structs.Noun{accuracy: 70, type: "noun", word: "고향"})
    assert Enum.member?(result, %KSA.Structs.Noun{accuracy: 70, type: "noun", word: "서울"})
  end
end
