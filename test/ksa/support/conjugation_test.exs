defmodule Support.ConjugationTest do
  use ExUnit.Case
  alias Ksa.Support.Conjugation
  
  describe "Present tense" do
    test "해" do
      assert Conjugation.conjugate("해") == "하"
    end
    
    test "먹어" do
      assert Conjugation.conjugate("먹어") == "먹"
    end
    
    test "신어" do
      assert Conjugation.conjugate("신어") == "신"
    end
    
    test "써" do
      assert Conjugation.conjugate("써") == "쓰"
    end
    
    test "울어" do
      assert Conjugation.conjugate("울어") == "울"
    end
    
    test "읽어" do
      assert Conjugation.conjugate("읽어") == "읽"
    end
    
    test "재미있어" do
      assert Conjugation.conjugate("재미있어") == "재미있"
    end
    
    test "줘" do
      assert Conjugation.conjugate("줘") == "주"
    end
    
    test "커" do
      assert Conjugation.conjugate("커") == "크"
    end
    
    test "필요없어" do
      assert Conjugation.conjugate("필요없어") == "필요없"
    end
    
    test "힘들어" do
      assert Conjugation.conjugate("힘들어") == "힘들"
    end
  end
  
  # https://www.koreanwikiproject.com/wiki/%EC%95%84/%EC%96%B4/%EC%97%AC_%2B_%EC%9A%94
  describe "Past tense" do
    test "했어" do
      assert Conjugation.conjugate("했어") == "하"
    end
    test "줬어" do
      assert Conjugation.conjugate("줬어") == "주"
    end
    
    test "썼어" do
      assert Conjugation.conjugate("썼어") == "쓰"
    end
    
    test "했는데" do
      assert Conjugation.conjugate("했는") == "하"
    end
    
    test "화났는데" do
      assert Conjugation.conjugate("화났는") == "화나"
    end
  end
  
  describe "Irregular" do
    test "dieut" do
      assert Enum.member?(Conjugation.conjugate_irregular("깨달"), "깨닫")
    end
    
    test "rieul" do
      assert Enum.member?(Conjugation.conjugate_irregular("노니"), "놀")
    end
    
    test "rieul_eu" do
      assert Enum.member?(Conjugation.conjugate_irregular("고릅"), "고르")
      assert Enum.member?(Conjugation.conjugate_irregular("골라"), "고르")
    end
    
    test "sieut" do
      assert Enum.member?(Conjugation.conjugate_irregular("지"), "짓")
    end

    test "hieuh_o" do
      assert Enum.member?(Conjugation.conjugate_irregular("그래"), "그렇")
      assert Enum.member?(Conjugation.conjugate_irregular("그랬"), "그렇")
      assert Enum.member?(Conjugation.conjugate_irregular("그럴"), "그렇")
    end
    
    test"hieuh_a" do
      assert Enum.member?(Conjugation.conjugate_irregular("까매"), "까맣")
      assert Enum.member?(Conjugation.conjugate_irregular("까맸"), "까맣")
      assert Enum.member?(Conjugation.conjugate_irregular("까말"), "까맣")
      assert Enum.member?(Conjugation.conjugate_irregular("까마"), "까맣")
    end

    test "bieup" do
      assert Enum.member?(Conjugation.conjugate_irregular("가벼워"), "가볍")
      assert Enum.member?(Conjugation.conjugate_irregular("가벼웠"), "가볍")
      assert Enum.member?(Conjugation.conjugate_irregular("가벼울"), "가볍")
      assert Enum.member?(Conjugation.conjugate_irregular("가벼우"), "가볍")
    end
  end
end
