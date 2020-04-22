defmodule Ksa.Structs.Substantive do
  @moduledoc """
  Defines the substantive
  """

  @type t :: %{word: String.t(), match: String.t(), type: String.t(), subtype: String.t(), base_rating: float}

  @enforce_keys [:word, :match, :subtype]
  defstruct [:word, :match, :subtype, type: "substantive", base_rating: 0.5]
end
