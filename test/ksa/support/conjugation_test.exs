defmodule Support.ConjugationHelperTest do
  use ExUnit.Case
  alias Ksa.Support.ConjugationHelper
  
  describe "Present tense - " do
    @tag :now
    test "먹어" do
      assert ConjugationHelper.conjugate("먹어") == "먹"
    end
    
    test "신어" do
      assert ConjugationHelper.conjugate("신어") == "신"
    end
    
    test "써" do
      assert ConjugationHelper.conjugate("써") == "쓰"
    end
    
    test "울어" do
      assert ConjugationHelper.conjugate("울어") == "울"
    end
    
    test "읽어" do
      assert ConjugationHelper.conjugate("읽어") == "읽"
    end
    
    test "재미있어" do
      assert ConjugationHelper.conjugate("재미있어") == "재미있"
    end
    
    test "줘" do
      assert ConjugationHelper.conjugate("줘") == "주"
    end
    
    test "커" do
      assert ConjugationHelper.conjugate("커") == "크"
    end
    
    test "필요없어" do
      assert ConjugationHelper.conjugate("필요없어") == "필요없"
    end

    test "힘들어" do
      assert ConjugationHelper.conjugate("힘들어") == "힘들"
    end
  end
end
