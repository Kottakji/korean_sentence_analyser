defmodule Words.DataTypes.NounTest do
  use ExUnit.Case
  import Ksa
  alias Ksa.Structs.Noun

  test "서울" do
    assert Enum.member?(analyse("서울"), %Noun{word: "서울", part: "서울", type: "noun"})
  end

  test "숲" do
    assert Enum.member?(analyse("숲"), %Noun{word: "숲", part: "숲", type: "noun"})
  end
end
