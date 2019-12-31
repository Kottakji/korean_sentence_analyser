defmodule KSA.Determiner do
  @moduledoc """
  A determiner can be me, you, this, that etc
  """

  @data_type "Determiner"
  @file_path "auxiliary/determiner.txt"

  @doc """
  Find if the word is a determiner

      iex> KSA.Determiner.find("그")
      %{"specific_type" => "Determiner", "token" => "그", "type" => "Determiner"}
  """
  def find(word) when byte_size(word) > 3 do
    word =
      case String.last(word) do
        "가" -> KSA.Word.get_remaining(word, "가")
        "이" -> KSA.Word.get_remaining(word, "이")
        "는" -> KSA.Word.get_remaining(word, "는")
        "은" -> KSA.Word.get_remaining(word, "은")
        "를" -> KSA.Word.get_remaining(word, "를")
        "을" -> KSA.Word.get_remaining(word, "을")
        "의" -> KSA.Word.get_remaining(word, "의")
        _ -> word
      end

    word
    |> KSA.LocalDict.find_in_file(@file_path)
    |> KSA.Formatter.print_result(@data_type)
  end

  def find(word) do
    word
    |> KSA.LocalDict.find_in_file(@file_path)
    |> KSA.Formatter.print_result(@data_type)
  end

  @doc """
  Removes a determiner (if present)
  """
  def remove(word) do
    case KSA.LocalDict.find_in_file(String.first(word), @file_path) do
      nil -> word
      match -> KSA.Word.get_remaining(word, match)
    end
  end
end
