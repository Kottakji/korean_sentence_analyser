defmodule Ksa do
  @moduledoc """
  Analyse Korean text
  """

  use Application

  @type t :: %{accuracy: pos_integer, type: String.t(), word: String.t()}

  @doc false
  def start(_type, _args) do
    Ksa.Ets.DictFile.init()
    Supervisor.start_link([], strategy: :one_for_one)
  end

  @doc """
  Analyse Korean text
  """
  @spec analyse(String.t()) :: list(t)
  def analyse(sentence) when is_bitstring(sentence) do
    [
      Ksa.DataTypes.Noun.match(sentence),
      Ksa.DataTypes.Adjective.match(sentence)
    ]
    |> Enum.concat()
  end
end
