defmodule Words.DataTypes.NounTest do
  use ExUnit.Case
  import Ksa.DataTypes.Noun, only: [match: 1]
  alias Ksa.Structs.Noun

  test "서울" do
    assert Enum.member?(match("서울"), %Noun{word: "서울", match: "서울", type: "noun", subtype: "noun"})
  end

  test "숲" do
    assert Enum.member?(match("숲"), %Noun{word: "숲", match: "숲", type: "noun", subtype: "noun"})
  end
end
