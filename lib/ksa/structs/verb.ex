defmodule Ksa.Structs.Verb do
  @moduledoc """
  Defines the verb
  """

  @type t :: %{word: String.t(), match: String.t(), type: String.t(), conjugated: Ksa.Structs.Conjugated.t()}

  @enforce_keys [:word, :match]
  defstruct [:word, :match, type: "verb", conjugated: nil]
end
