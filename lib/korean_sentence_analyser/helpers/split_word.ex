defmodule KSA.SplitWord do
  @moduledoc """
  Helpful module when dealing with words that do not have proper spacing
  """

  @doc """
  Find the words when a word contains multiple words without spacing in between

      iex> KSA.SplitWord.find("성열이냐")
      [
        %{"specific_type" => "Given name", "token" => "성열", "type" => "Substantive"},
        %{"specific_type" => "Adjective", "token" => "이다", "type" => "Adjective"}
      ]
    
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
         |> KSA.Word.find() do
      nil ->
        word_list
        |> Enum.drop(-1)
        |> find(word, result)

      _match = %{"token" => "요"} ->
        # Do not match 요
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

      matches = [%{"token" => token1}, %{"token" => token2}] ->
        len = String.length(token1) + String.length(token2)

        word
        |> String.split("")
        |> Enum.filter(fn x -> x != "" end)
        |> Enum.drop(len)
        |> find(String.slice(word, len, String.length(word)), result ++ matches)
    end
  end
end
