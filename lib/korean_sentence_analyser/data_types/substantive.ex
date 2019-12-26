defmodule KoreanSentenceAnalyser.DataTypes.Substantive do
  @moduledoc """
  A substantive can be a given name, or a family name
  """
  alias KoreanSentenceAnalyser.Helpers.Dict
  alias KoreanSentenceAnalyser.Helpers.Formatter
  @data_type "Substantive"
  
  @doc """
  Find if the word is a substantive
  """
  def find(word) do
    with nil <- given_name(word),
         nil <- family_name(word),
         do: nil
  end

  @doc """
  Find if the word is a substantive, removing any Josa (grammar) attached to the word
  """
  def find_without_josa(word) do
    with nil <- given_name(word, true),
         nil <- family_name(word, true),
         do: nil
  end

  @doc """
  Find if the word is a given name
  """
  def given_name(word, remove_josa \\ false) do
    Dict.find_in_file(word, "data/substantives/given_names.txt", remove_josa)
    |> Formatter.print_result(@data_type, "Given name")
  end

  @doc """
  Find if the word is a family name
  """
  def family_name(word, remove_josa \\ false) do
    Dict.find_in_file(word, "data/substantives/family_names.txt", remove_josa)
    |> Formatter.print_result(@data_type, "Family name")
  end
end
