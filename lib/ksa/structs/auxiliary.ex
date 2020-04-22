defmodule Ksa.Structs.Auxiliary do
  @moduledoc """
  Defines the auxiliary
  """

  @type t :: %{word: String.t(), match: String.t(), type: String.t(), subtype: String.t()}

  @enforce_keys [:word, :match, :subtype]
  defstruct [:word, :match, :subtype, type: "auxiliary"]
end
