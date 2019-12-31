defmodule KSA.PreEomi do
  @moduledoc """
  A pre-eomi is a conjugation added to Korean words at the beginning
  """

  @file_path "verb/pre_eomi.txt"

  @doc """
  Removes a pre-eomi
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
  Find a pre-eomi
  """
  def find(word) do
    KSA.LocalDict.find_ending_in_file(word, @file_path)
  end
end
