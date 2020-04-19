defmodule Sentences.DataTypes.AdjectiveTest do
  use ExUnit.Case
  import Ksa, only: [analyse: 1]
  alias Ksa.Structs.Adjective
  
  test "옛날의 서울의 모습이 몹시 그립습니다" do
    result = analyse("옛날의 서울의 모습이 몹시 그립습니다")
    
    assert Enum.member?(
             result,
             %Adjective{
               conjugated: nil,
               match: "그립",
               type: "adjective",
               word: "그립습니다"
             }
           )
  end
end
