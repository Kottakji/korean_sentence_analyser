defmodule Support.ConjugationTest do
  use ExUnit.Case
  import Ksa.Support.Conjugation, only: [conjugate: 1, conjugate_irregular: 1, conjugate_passive: 1]
  alias Ksa.Structs.Conjugated
  use Ksa.Constants

  describe "Regular" do
    test "a" do
      assert Enum.member?(
               conjugate("해"),
               %Conjugated{word: "해", conjugated: "하", tense: @present_tense, sub_type: "regular"}
             )

      assert Enum.member?(conjugate("했"), %Conjugated{word: "했", conjugated: "하", tense: @past_tense, sub_type: "regular"})

      assert Enum.member?(
               conjugate("합"),
               %Conjugated{word: "합", conjugated: "하", tense: @present_formal_tense, sub_type: "regular"}
             )

      assert Enum.member?(
               conjugate("한"),
               %Conjugated{word: "한", conjugated: "하", tense: @past_written_tense, sub_type: "regular"}
             )

      assert Enum.member?(conjugate("할"), %Conjugated{word: "할", conjugated: "하", tense: @future_tense, sub_type: "regular"})

      assert Enum.member?(
               conjugate("함"),
               %Conjugated{word: "함", conjugated: "하", tense: @nominal_tense, sub_type: "regular"}
             )
    end

    test "eu" do
      assert Enum.member?(
               conjugate("써"),
               %Conjugated{word: "써", conjugated: "쓰", tense: @present_tense, sub_type: "regular"}
             )

      assert Enum.member?(conjugate("썼"), %Conjugated{word: "썼", conjugated: "쓰", tense: @past_tense, sub_type: "regular"})

      assert Enum.member?(
               conjugate("씁"),
               %Conjugated{word: "씁", conjugated: "쓰", tense: @present_formal_tense, sub_type: "regular"}
             )

      assert Enum.member?(
               conjugate("쓴"),
               %Conjugated{word: "쓴", conjugated: "쓰", tense: @past_written_tense, sub_type: "regular"}
             )

      assert Enum.member?(conjugate("쓸"), %Conjugated{word: "쓸", conjugated: "쓰", tense: @future_tense, sub_type: "regular"})

      assert Enum.member?(
               conjugate("씀"),
               %Conjugated{word: "씀", conjugated: "쓰", tense: @nominal_tense, sub_type: "regular"}
             )
    end

    test "rieul" do
      assert Enum.member?(
               conjugate("운"),
               %Conjugated{word: "운", conjugated: "울", tense: @past_written_tense, sub_type: "regular"}
             )

      assert Enum.member?(
               conjugate("웁"),
               %Conjugated{word: "웁", conjugated: "울", tense: @present_formal_tense, sub_type: "regular"}
             )

      assert Enum.member?(
               conjugate("우"),
               %Conjugated{word: "우", conjugated: "울", tense: @imperative_tense, sub_type: "regular"}
             )

      assert Enum.member?(
               conjugate("욺"),
               %Conjugated{word: "욺", conjugated: "울", tense: @nominal_tense, sub_type: "regular"}
             )
    end

    test "u" do
      assert Enum.member?(
               conjugate("줘"),
               %Conjugated{word: "줘", conjugated: "주", tense: @present_tense, sub_type: "regular"}
             )

      assert Enum.member?(
               conjugate("준"),
               %Conjugated{word: "준", conjugated: "주", tense: @past_written_tense, sub_type: "regular"}
             )

      assert Enum.member?(conjugate("줬"), %Conjugated{word: "줬", conjugated: "주", tense: @past_tense, sub_type: "regular"})
      assert Enum.member?(conjugate("줄"), %Conjugated{word: "줄", conjugated: "주", tense: @future_tense, sub_type: "regular"})

      assert Enum.member?(
               conjugate("줍"),
               %Conjugated{word: "줍", conjugated: "주", tense: @present_formal_tense, sub_type: "regular"}
             )

      assert Enum.member?(
               conjugate("줌"),
               %Conjugated{word: "줌", conjugated: "주", tense: @nominal_tense, sub_type: "regular"}
             )
    end

    test @past_tense do
      assert Enum.member?(
               conjugate("짰"),
               %Conjugated{word: "짰", conjugated: "짜", tense: @past_tense, sub_type: "regular"}
             )
    end

    test "Only unique values are returned" do
      assert Enum.count(conjugate("가능하")) == 1
    end
  end

  describe "Irregular" do
    test "dieut" do
      assert Enum.member?(
               conjugate_irregular("깨달"),
               %Conjugated{word: "깨달", conjugated: "깨닫", tense: @present_tense, sub_type: "irregular"}
             )

      assert Enum.member?(
               conjugate_irregular("깨단"),
               %Conjugated{word: "깨단", conjugated: "깨닫", tense: @past_written_tense, sub_type: "irregular"}
             )

      assert Enum.member?(
               conjugate_irregular("깨답"),
               %Conjugated{word: "깨답", conjugated: "깨닫", tense: @present_formal_tense, sub_type: "irregular"}
             )
    end

    test "rieul" do
      assert Enum.member?(
               conjugate_irregular("논"),
               %Conjugated{word: "논", conjugated: "놀", tense: @past_written_tense, sub_type: "irregular"}
             )

      assert Enum.member?(
               conjugate_irregular("놉"),
               %Conjugated{word: "놉", conjugated: "놀", tense: @present_formal_tense, sub_type: "irregular"}
             )

      assert Enum.member?(
               conjugate_irregular("노"),
               %Conjugated{word: "노", conjugated: "놀", tense: @imperative_tense, sub_type: "irregular"}
             )

      assert Enum.member?(
               conjugate_irregular("놂"),
               %Conjugated{word: "놂", conjugated: "놀", tense: @nominal_tense, sub_type: "irregular"}
             )
    end

    test "rieul_eu" do
      assert Enum.member?(
               conjugate_irregular("골라"),
               %Conjugated{word: "골라", conjugated: "고르", tense: @present_tense, sub_type: "irregular"}
             )

      assert Enum.member?(
               conjugate_irregular("고른"),
               %Conjugated{word: "고른", conjugated: "고르", tense: @past_written_tense, sub_type: "irregular"}
             )

      assert Enum.member?(
               conjugate_irregular("골랐"),
               %Conjugated{word: "골랐", conjugated: "고르", tense: @past_tense, sub_type: "irregular"}
             )

      assert Enum.member?(
               conjugate_irregular("고를"),
               %Conjugated{word: "고를", conjugated: "고르", tense: @future_tense, sub_type: "irregular"}
             )

      assert Enum.member?(
               conjugate_irregular("고릅"),
               %Conjugated{word: "고릅", conjugated: "고르", tense: @present_formal_tense, sub_type: "irregular"}
             )

      assert Enum.member?(
               conjugate_irregular("고름"),
               %Conjugated{word: "고름", conjugated: "고르", tense: @nominal_tense, sub_type: "irregular"}
             )
    end

    test "sieut" do
      assert Enum.member?(
               conjugate_irregular("지"),
               %Conjugated{word: "지", conjugated: "짓", tense: @present_tense, sub_type: "irregular"}
             )
    end

    test "hieuh_o" do
      assert Enum.member?(
               conjugate_irregular("그래"),
               %Conjugated{word: "그래", conjugated: "그렇", tense: @present_tense, sub_type: "irregular"}
             )

      assert Enum.member?(
               conjugate_irregular("그랬"),
               %Conjugated{word: "그랬", conjugated: "그렇", tense: @past_tense, sub_type: "irregular"}
             )

      assert Enum.member?(
               conjugate_irregular("그럴"),
               %Conjugated{word: "그럴", conjugated: "그렇", tense: @future_tense, sub_type: "irregular"}
             )

      assert Enum.member?(
               conjugate_irregular("그럼"),
               %Conjugated{word: "그럼", conjugated: "그렇", tense: @nominal_tense, sub_type: "irregular"}
             )

      assert Enum.member?(
               conjugate_irregular("그러"),
               %Conjugated{word: "그러", conjugated: "그렇", tense: @imperative_tense, sub_type: "irregular"}
             )
    end

    test "hieuh_a" do
      assert Enum.member?(
               conjugate_irregular("까매"),
               %Conjugated{word: "까매", conjugated: "까맣", tense: @present_tense, sub_type: "irregular"}
             )

      assert Enum.member?(
               conjugate_irregular("까맸"),
               %Conjugated{word: "까맸", conjugated: "까맣", tense: @past_tense, sub_type: "irregular"}
             )

      assert Enum.member?(
               conjugate_irregular("까말"),
               %Conjugated{word: "까말", conjugated: "까맣", tense: @future_tense, sub_type: "irregular"}
             )

      assert Enum.member?(
               conjugate_irregular("까마"),
               %Conjugated{word: "까마", conjugated: "까맣", tense: @imperative_tense, sub_type: "irregular"}
             )

      assert Enum.member?(
               conjugate_irregular("까맘"),
               %Conjugated{word: "까맘", conjugated: "까맣", tense: @nominal_tense, sub_type: "irregular"}
             )
    end

    test "bieup" do
      assert Enum.member?(
               conjugate_irregular("가벼"),
               %Conjugated{word: "가벼", conjugated: "가볍", tense: @present_tense, sub_type: "irregular"}
             )
    end

    test "Only unique values are returned" do
      assert Enum.count(conjugate_irregular("가능하")) == 5
    end
  end

  describe "Passive form" do
    test "ieung_ee" do
      assert Enum.member?(conjugate_passive("바뀌"), %Conjugated{word: "바뀌", conjugated: "바꾸", tense: @present_tense, sub_type: "passive"})
      assert Enum.member?(conjugate_passive("바뀐"), %Conjugated{word: "바뀐", conjugated: "바꾸", tense: @past_written_tense, sub_type: "passive"})
      assert Enum.member?(conjugate_passive("바뀝"), %Conjugated{word: "바뀝", conjugated: "바꾸", tense: @present_formal_tense, sub_type: "passive"})
      assert Enum.member?(conjugate_passive("바뀔"), %Conjugated{word: "바뀔", conjugated: "바꾸", tense: @future_tense, sub_type: "passive"})
      assert Enum.member?(conjugate_passive("바뀜"), %Conjugated{word: "바뀜", conjugated: "바꾸", tense: @nominal_tense, sub_type: "passive"})
    end
  end
end
