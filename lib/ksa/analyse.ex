defmodule Ksa.Analyse do
  @moduledoc """
  Analyses the results
  """
  alias Ksa.Structs.{Match, Adverb, Auxiliary, Noun, Substantive, Verb,Conjugated}
  
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
  def rate(match = %Verb{conjugated: %Conjugated{word: m}, word: w}) when byte_size(m) > 3 do
    cond do
      String.starts_with?(w, m) ->
        %Match{
          child: match,
          rating: 0.6 * (match.base_rating * (String.length(m) / String.length(w))) * Verb.get_conjugation_score(match)
        }
      true ->
        %Match{
          child: match,
          rating: 0.4 * (match.base_rating * (String.length(m) / String.length(w))) * Verb.get_conjugation_score(match)
        }
    end
  end

  @spec rate(matched) :: Match.t()
  def rate(match = %{match: m, word: w}) when byte_size(m) > 3 do
    cond do
      String.starts_with?(w, m) ->
        %Match{
          child: match,
          rating: 0.5 * (match.base_rating * (String.length(m) / String.length(w)))
        }
      true ->
        %Match{
          child: match,
          rating: 0.3 * (match.base_rating * (String.length(m) / String.length(w)))
        }
    end
  end

  @spec rate(matched) :: Match.t()
  def rate(match = %Verb{conjugated: %Conjugated{word: m}, word: w}) do
    cond do
      String.starts_with?(w, m) ->
        %Match{
          child: match,
          rating: 0.2 * (match.base_rating * (String.length(m) / String.length(w))) * Verb.get_conjugation_score(match)
        }
      true ->
        %Match{
          child: match,
          rating: 0.1 * (match.base_rating * (String.length(m) / String.length(w))) * Verb.get_conjugation_score(match)
        }
    end
  end
  
  @spec rate(matched) :: Match.t()
  def rate(match = %{match: m, word: w}) do
    cond do
      String.starts_with?(w, m) ->
        %Match{
          child: match,
          rating: 0.2 * (match.base_rating * (String.length(m) / String.length(w)))
        }
      true ->
        %Match{
          child: match,
          rating: 0.1 * (match.base_rating * (String.length(m) / String.length(w)))
        }
    end
  end
end
