defmodule Ksa.Structs.Adverb do
  @moduledoc """
  Defines the adverb
  """

  @type t :: %{word: String.t(), match: String.t(), type: String.t(), base_rating: float}

  @enforce_keys [:word, :match]
  defstruct [:word, :match, type: "adverb", base_rating: 0.9]
end
