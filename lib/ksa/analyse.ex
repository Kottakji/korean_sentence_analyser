defmodule Ksa.Analyse do
  @moduledoc false
  use Ksa.Constants
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

    modifier = modifier + get_ending_score(w, m)

    cond do
      String.starts_with?(w, m) ->
        %Match{
          child: match,
          rating: (0.5 + modifier) * (match.base_rating * (String.length(m) / String.length(w))) * get_conjugation_score(match)
        }

      String.ends_with?(w, m) ->
        %Match{
          child: match,
          rating: 0.09 * (match.base_rating * (String.length(m) / String.length(w)))
        }

      true ->
        %Match{
          child: match,
          rating: (0.4 + modifier) * (match.base_rating * (String.length(m) / String.length(w)))
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

    cond do
      String.starts_with?(w, m) ->
        %Match{
          child: match,
          rating: (0.2 + modifier) * (match.base_rating * (String.length(m) / String.length(w)))
        }

      String.ends_with?(w, m) ->
        %Match{
          child: match,
          rating: 0.001 * (match.base_rating * (String.length(m) / String.length(w)))
        }

      true ->
        %Match{
          child: match,
          rating: (0.05 + modifier) * (match.base_rating * (String.length(m) / String.length(w)))
        }
    end
  end

  @doc false
  @spec get_conjugation_score(Ksa.Structs.Verb.t()) :: float
  def get_conjugation_score(_match = %Ksa.Structs.Verb{conjugated: %Ksa.Structs.Conjugated{tense: tense}}) do
    case tense do
      @present_tense -> 1
      @present_formal_tense -> 1
      @past_tense -> 0.95
      @past_written_tense -> 0.9
      @future_tense -> 0.9
      @imperative_tense -> 0.85
      @nominal_tense -> 0.86
    end
  end

  @doc false
  @spec get_conjugation_score(Ksa.Structs.Verb.t()) :: float
  def get_conjugation_score(_match = %Ksa.Structs.Verb{}) do
    1
  end

  @doc false
  @spec get_ending_score(String.t(), String.t()) :: float
  def get_ending_score(word, match) do
    cond do
      word == match <> "아야" -> 1
      word == match <> "고" -> 0.5
      word == match <> "니까" -> 0.5
      word == match <> "서" -> 0.5
      word == match <> "서" -> 0.5
      true -> 0
    end
  end
end
