defmodule Ksa.Structs.Adverb do
  @moduledoc """
  Defines the adverb
  """

  @type t :: %{word: String.t(), match: String.t(), type: String.t()}

  @enforce_keys [:word, :match]
  defstruct [:word, :match, type: "adverb"]
end
