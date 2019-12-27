defmodule KoreanSentenceAnalyser.DataTypes.Determiner do
  @moduledoc """
  A determiner can be me, you, this, that etc
  """

  alias KoreanSentenceAnalyser.Helpers.Word
  alias KoreanSentenceAnalyser.Helpers.Formatter
  alias KoreanSentenceAnalyser.Helpers.Dict

  @data_type "Determiner"
  @file_path "data/auxiliary/determiner.txt"

  @doc """
  Find if the word is a determiner
  """
  def find(word) when byte_size(word) > 3 do
    word =
      case String.last(word) do
        "가" -> Word.get_remaining(word, "가")
        "이" -> Word.get_remaining(word, "이")
        "는" -> Word.get_remaining(word, "는")
        "은" -> Word.get_remaining(word, "은")
        "를" -> Word.get_remaining(word, "를")
        "을" -> Word.get_remaining(word, "을")
        "의" -> Word.get_remaining(word, "의")
        _ -> word
      end

    word
    |> Dict.find_in_file(@file_path)
    |> Formatter.print_result(@data_type)
  end

  def find(word) do
    word
    |> Dict.find_in_file(@file_path)
    |> Formatter.print_result(@data_type)
  end
end
