defmodule Ksa do
  @moduledoc """
  Analyse Korean text
  """
  use Application
  alias Ksa.Structs.{Adjective, Verb}

  @doc false
  def start(_type, _args) do
    Ksa.Ets.DictFile.init()
    Supervisor.start_link([], strategy: :one_for_one)
  end

  @doc """
  Analyse Korean text
  """
  @spec analyse(String.t(), boolean) :: list
  def analyse(sentence, filter \\ true) when is_bitstring(sentence) do
    result =
      [
        Ksa.DataTypes.Adjective.match(sentence),
        Ksa.DataTypes.Adverb.match(sentence),
        Ksa.DataTypes.Auxiliary.match(sentence),
        Ksa.DataTypes.Noun.match(sentence),
        Ksa.DataTypes.Substantive.match(sentence),
        Ksa.DataTypes.Verb.match(sentence)
      ]
      |> Enum.concat()
      |> Ksa.Analyse.analyse()
      |> Enum.sort(&(&1.rating >= &2.rating))

    case filter do
      true -> filter(result)
      false -> result
    end
  end

  @spec filter(list) :: list
  defp filter(matches) when is_list(matches) do
    matches
    |> Enum.group_by(fn x -> x.child.word end)
    |> Enum.map(fn {key, matches} ->
      max = Enum.max_by(matches, fn x -> x.rating end)

      case max.child do
        %Verb{match: match} ->
          %{key => match <> "다"}

        %Adjective{match: match} ->
          %{key => match <> "다"}

        child ->
          %{key => child.match}
      end
    end)
  end
end
