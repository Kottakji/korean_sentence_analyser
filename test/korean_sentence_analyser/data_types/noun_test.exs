defmodule NounTest do
  use ExUnit.Case
  import AssertValue

  describe "We can find nouns - " do
    test "bible - 압살롬" do
      assert_value(
        KoreanSentenceAnalyser.analyse_word("압살롬") == %{
          "specific_type" => "Bible",
          "token" => "압살롬",
          "type" => "Noun"
        }
      )
    end

    test "brand - 폴로" do
      assert_value(
        KoreanSentenceAnalyser.analyse_word("폴로") == %{
          "specific_type" => "Brand",
          "token" => "폴로",
          "type" => "Noun"
        }
      )
    end

    test "company name - 한진" do
      assert_value(
        KoreanSentenceAnalyser.analyse_word("한진") == %{
          "specific_type" => "Company name",
          "token" => "한진",
          "type" => "Noun"
        }
      )
    end

    test "congress - 강강강" do
      assert_value(
        KoreanSentenceAnalyser.analyse_word("강강강") == %{
          "specific_type" => "Congress",
          "token" => "강강강",
          "type" => "Noun"
        }
      )
    end

    test "entity - 가스요금" do
      assert_value(
        KoreanSentenceAnalyser.analyse_word("가스요금") == %{
          "specific_type" => "Entities",
          "token" => "가스요금",
          "type" => "Noun"
        }
      )
    end

    test "fashion - 후리스" do
      assert_value(
        KoreanSentenceAnalyser.analyse_word("후리스") == %{
          "specific_type" => "Fashion",
          "token" => "후리스",
          "type" => "Noun"
        }
      )
    end

    test "foreign - 고이치" do
      assert_value(
        KoreanSentenceAnalyser.analyse_word("고이치") == %{
          "specific_type" => "Foreign",
          "token" => "고이치",
          "type" => "Noun"
        }
      )
    end

    test "geolocation - 호치민" do
      assert_value(
        KoreanSentenceAnalyser.analyse_word("호치민") == %{
          "specific_type" => "Geolocation",
          "token" => "호치민",
          "type" => "Noun"
        }
      )
    end

    test "kpop - 강수지" do
      assert_value(
        KoreanSentenceAnalyser.analyse_word("강수지") == %{
          "specific_type" => "K-pop",
          "token" => "강수지",
          "type" => "Noun"
        }
      )
    end

    test "lol - 노틸러스" do
      assert_value(
        KoreanSentenceAnalyser.analyse_word("노틸러스") == %{
          "specific_type" => "Lol",
          "token" => "노틸러스",
          "type" => "Noun"
        }
      )
    end

    test "names - 김유이" do
      assert_value(
        KoreanSentenceAnalyser.analyse_word("김유이") == %{
          "specific_type" => "Name",
          "token" => "김유이",
          "type" => "Noun"
        }
      )
    end

    test "neologism - 떡코" do
      assert_value(
        KoreanSentenceAnalyser.analyse_word("떡코") == %{
          "specific_type" => "Neologism",
          "token" => "떡코",
          "type" => "Noun"
        }
      )
    end

    test "nouns - 객공잡이" do
      assert_value(
        KoreanSentenceAnalyser.analyse_word("객공잡이") == %{
          "specific_type" => "Noun",
          "token" => "객공잡이",
          "type" => "Noun"
        }
      )
    end

    test "pokemon - 기가이어스" do
      assert_value(
        KoreanSentenceAnalyser.analyse_word("기가이어스") == %{
          "specific_type" => "Pokemon",
          "token" => "기가이어스",
          "type" => "Noun"
        }
      )
    end

    test "profane - 로리콘" do
      assert_value(
        KoreanSentenceAnalyser.analyse_word("로리콘") == %{
          "specific_type" => "Profane",
          "token" => "로리콘",
          "type" => "Noun"
        }
      )
    end

    test "slangs - 가까오떡" do
      assert_value(
        KoreanSentenceAnalyser.analyse_word("가까오떡") == %{
          "specific_type" => "Slang",
          "token" => "가까오떡",
          "type" => "Noun"
        }
      )
    end

    test "spam - 강원랜드" do
      assert_value(
        KoreanSentenceAnalyser.analyse_word("강원랜드") == %{
          "specific_type" => "Spam",
          "token" => "강원랜드",
          "type" => "Noun"
        }
      )
    end

    test "twitter - 해쉬태그" do
      assert_value(
        KoreanSentenceAnalyser.analyse_word("해쉬태그") == %{
          "specific_type" => "Twitter",
          "token" => "해쉬태그",
          "type" => "Noun"
        }
      )
    end

    test "wikipedia title nouns - 가가미모치" do
      assert_value(
        KoreanSentenceAnalyser.analyse_word("가가미모치") == %{
          "specific_type" => "Wikipedia title noun",
          "token" => "가가미모치",
          "type" => "Noun"
        }
      )
    end
  end
end
