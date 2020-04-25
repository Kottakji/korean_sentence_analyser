defmodule Ksa.Analyse do
  @moduledoc """
  Analyses the results
  """
  alias Ksa.Structs.{Match, Adverb, Auxiliary, Noun, Substantive, Verb, Conjugated}

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
  def rate(match = %Verb{}) do
    # Use either the conjugated or the non-conjugated match
    m =
      if match.conjugated do
        match.conjugated.conjugated
      else
        match.match
      end

    w = match.word

    # Short verbs should not match easily
    modifier =
      if byte_size(m) < 6 do
        -0.3
      else
        0
      end

    # If it ends with 아야, it's a verb
    modifier =
      if w == m <> "아야" do
        modifier + 1
      else
        modifier
      end

    # If it ends with 아야, it's a most likely a verb
    modifier =
      if w == m <> "고" do
        modifier + 0.5
      else
        modifier
      end

    cond do
      String.starts_with?(w, m) ->
        %Match{
          child: match,
          rating: (0.5 + modifier) * (match.base_rating * (String.length(m) / String.length(w))) * Verb.get_conjugation_score(match)
        }

      true ->
        %Match{
          child: match,
          rating: 0.4 * (match.base_rating * (String.length(m) / String.length(w)))
        }
    end
  end

  @spec rate(matched) :: Match.t()
  def rate(match = %{match: m, word: w}) do
    # Short words should not match easily
    modifier =
      if byte_size(m) > 3 do
        0.3
      else
        0
      end

    # Words that are at the end should most likely not match
    modifier =
      if String.ends_with?(w, m) do
        modifier - 0.2
      else
        modifier
      end

    cond do
      String.starts_with?(w, m) ->
        %Match{
          child: match,
          rating: (0.2 + modifier) * (match.base_rating * (String.length(m) / String.length(w)))
        }

      true ->
        %Match{
          child: match,
          rating: (0.05 + modifier) * (match.base_rating * (String.length(m) / String.length(w)))
        }
    end
  end
end
