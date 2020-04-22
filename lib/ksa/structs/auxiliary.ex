defmodule Ksa.Structs.Auxiliary do
  @moduledoc """
  Defines the auxiliary
  """

  @type t :: %{word: String.t(), match: String.t(), type: String.t(), subtype: String.t(), base_rating: float}

  @enforce_keys [:word, :match, :subtype]
  defstruct [:word, :match, :subtype, type: "auxiliary", base_rating: 0.7]
end
