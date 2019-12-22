defmodule KoreanSentenceAnalyser.Helpers.SplitWord do
  alias KoreanSentenceAnalyser.Helpers.Word

  @moduledoc """
  """

  @doc """
  Find the words when a word contains multiple words without spacing in between
  """
  def find(word) when is_binary(word) do
    word
    |> String.split("")
    |> Enum.filter(fn x -> x != "" end)
    |> find(word, [])
  end

  def find([], _word, result) do
    result
  end

  def find(word_list, word, result) when is_list(word_list) do
    case word_list
         |> Enum.reduce(fn x, acc -> acc <> x end)
         |> Word.find() do
      nil ->
        word_list
        |> Enum.drop(-1)
        |> find(word, result)

      match = %{"token" => token} ->
        len = String.length(token)

        word
        |> String.split("")
        |> Enum.filter(fn x -> x != "" end)
        |> Enum.drop(len)
        |> find(String.slice(word, len, String.length(word)), result ++ [match])
    end
  end
end
