defmodule Sentences.DataTypes.VerbTest do
  use ExUnit.Case
  import Ksa, only: [analyse: 1]
  alias Ksa.Structs.Verb
  
  test "밥 먹어" do
    result = analyse("밥 먹어")
    
    assert Enum.member?(result, %Verb{conjugated: nil, match: "먹", type: "verb", word: "먹어"})
  end
end
