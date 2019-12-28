defmodule Substantive do
  @moduledoc """
  A substantive can be a given name, or a family name
  """
  
  alias LocalDict
  alias Formatter
  
  @data_type "Substantive"

  @doc """
  Find if the word is a substantive
  
      iex> Substantive.find("경수")
      %{"specific_type" => "Given name", "token" => "경수", "type" => "Substantive"}
    
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
    with nil <- given_name(word, :remove_josa),
         nil <- family_name(word, :remove_josa),
         do: nil
  end

  @doc """
  Find if the word is a given name
  
      iex> Substantive.given_name("경수")
      %{"specific_type" => "Given name", "token" => "경수", "type" => "Substantive"}
    
  """
  def given_name(word, option \\ nil) do
    LocalDict.find_in_file(word, "data/substantives/given_names.txt", option)
    |> Formatter.print_result(@data_type, "Given name")
  end

  @doc """
  Find if the word is a family name
  
      iex> Substantive.family_name("박")
      %{"specific_type" => "Family name", "token" => "박", "type" => "Substantive"}
    
  """
  def family_name(word, option \\ nil) do
    LocalDict.find_in_file(word, "data/substantives/family_names.txt", option)
    |> Formatter.print_result(@data_type, "Family name")
  end
end
