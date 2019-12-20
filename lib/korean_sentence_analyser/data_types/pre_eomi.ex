defmodule KoreanSentenceAnalyser.DataTypes.PreEomi do
  alias KoreanSentenceAnalyser.Helpers.Dict

  @moduledoc """
  Particles that can come before an Eomi
  """

  @doc """
  Remove a pre-eomi
  """
  def remove(word) do
    case find(word) do
      nil ->
        word

      match ->
        Regex.replace(Regex.compile!(match <> "$", "u"), word, "")
    end
  end

  @doc """
  Find a pre eomi
  """
  def find(word) do
    Dict.find_ending_in_file(word, "data/verb/pre_eomi.txt")
  end
end
