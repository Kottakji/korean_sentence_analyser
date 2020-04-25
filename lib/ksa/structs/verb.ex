defmodule Ksa.Structs.Verb do
  @moduledoc """
  Defines the verb
  """
  use Ksa.Constants

  @type t :: %{word: String.t(), match: String.t(), type: String.t(), conjugated: Ksa.Structs.Conjugated.t(), base_rating: float}

  @enforce_keys [:word, :match]
  defstruct [:word, :match, type: "verb", conjugated: nil, base_rating: 0.6]

  @spec get_conjugation_score(t()) :: float
  def get_conjugation_score(match = %Ksa.Structs.Verb{conjugated: %Ksa.Structs.Conjugated{tense: tense}}) do
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

  @spec get_conjugation_score(t()) :: float
  def get_conjugation_score(match = %Ksa.Structs.Verb{}) do
    1
  end
end
