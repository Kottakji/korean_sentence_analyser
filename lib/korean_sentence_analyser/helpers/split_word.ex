defmodule KoreanSentenceAnalyser.Helpers.SplitWord do
  @moduledoc """
  Helpful module when dealing with words that do not have proper spacing
  """

  alias KoreanSentenceAnalyser.Helpers.Word

  @doc """
  Find the words when a word contains multiple words without spacing in between
  """
  def find(word) when is_binary(word) do
    word
    |> String.split("")
    |> Enum.filter(fn x -> x != "" end)
    |> find(word, [])
  end

  defp find([], _word, result) do
    result
  end

  defp find(word_list, word, result) when is_list(word_list) do
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
