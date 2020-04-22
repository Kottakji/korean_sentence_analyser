defmodule Ksa.Analyse do
  @moduledoc """
  Analyses the results
  """
  alias Ksa.Structs.{Match, Adverb, Auxiliary, Noun, Substantive, Verb}
  
  @type matched :: Adverb.t() | Auxiliary.t() | Noun.t() | Substantive.t() | Verb.t()
  
  @spec analyse(list) :: list
  def analyse(list) when is_list(list) do
    list
    |> Enum.map(fn match -> rate(match) end)
  end

  @spec rate(matched) :: Match.t()
  def rate(match = %{match: m, word: w}) when m == w do
    %Match{
      child: match,
      rating: 1 * match.base_rating
    }
  end
  
  @spec rate(matched) :: Match.t()
  def rate(match) do
    %Match{
      child: match,
      rating: 0.1 * match.base_rating
    }
  end
end
