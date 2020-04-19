defmodule Ksa.Structs.Adjective do
  @moduledoc """
  Defines the adjective
  """

  @type t :: %{word: String.t(), match: String.t(), type: String.t(), conjugated: Ksa.Structs.Conjugated.t()}

  @enforce_keys [:word, :match]
  defstruct [:word, :match, type: "adjective", conjugated: nil]
end
