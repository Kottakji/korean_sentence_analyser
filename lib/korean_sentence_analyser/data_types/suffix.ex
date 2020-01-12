defmodule KSA.Suffix do
  @moduledoc """
  Matches nouns that have a suffix attached
  For example: 4년째
  """

  @data_type "Suffix"
  @file_path "substantives/suffix.txt"

  @doc """
  Find a noun when it has a Suffix ending

      iex> KSA.Suffix.find("지역내")
      [
        %{
          "specific_type" => "Noun",
          "token" => "지역",
          "type" => "Noun"
        },
        %{
          "specific_type" => "Grammar",
          "token" => "내",
          "type" => "Grammar"
        }
      ]

  """
  def find(word) do
    case KSA.LocalDict.find_ending_in_file(word, @file_path) do
      nil -> nil
      match -> find(word, match)
    end
  end

  defp find(word, match) do
    remains = KSA.Word.get_remaining(word, match)

    case KSA.Noun.find(remains) do
      nil ->
        nil

      remains_match ->
        [
          remains_match,
          KSA.Formatter.print_result(match, @data_type)
        ]
    end
  end
end
