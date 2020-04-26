defmodule Ksa.Structs.Verb do
  @moduledoc """
  Defines the verb
  """
  use Ksa.Constants

  @type t :: %{word: String.t(), match: String.t(), type: String.t(), conjugated: Ksa.Structs.Conjugated.t(), base_rating: float}

  @enforce_keys [:word, :match]
  defstruct [:word, :match, type: "verb", conjugated: nil, base_rating: 0.7]
end
