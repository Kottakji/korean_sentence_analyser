defmodule KSA.Verb do
  @moduledoc false

  @data_type "Verb"
  @file_path "verb/verb.txt"

  @doc """
  Find if the word is a verb

      iex> KSA.Verb.find("먹다")
      %{"specific_type" => "Verb", "token" => "먹다", "type" => "Verb"}
    
  """
  def find(word) do
    word
    |> find(@file_path)
    |> KSA.Formatter.add_ending("다")
    |> KSA.Formatter.print_result(@data_type)
  end

  defp find(nil, _) do
    nil
  end

  defp find("", _) do
    nil
  end

  defp find("입니가", _) do
    "입니"
  end

  defp find("입니다", _) do
    "입니"
  end

  defp find(word, file) do
    case KSA.LocalDict.find_in_file(word, file) do
      nil ->
        case KSA.Eomi.remove(word) do
          new_word when new_word != word ->
            find(new_word, file)

          _ ->
            word
            |> KSA.Stem.find()
            |> KSA.LocalDict.find_in_file(file)
        end

      match ->
        match
    end
  end
end
