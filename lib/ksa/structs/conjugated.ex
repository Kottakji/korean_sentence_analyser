defmodule Ksa.Structs.Conjugated do
  @moduledoc """
  Defines a conjugated
  """
  @type t :: %{word: String.t(), conjugated: String.t(), tense: String.t(), type: String.t(), sub_type: String.t()}

  @enforce_keys [:word, :conjugated, :tense, :sub_type]
  defstruct [:word, :conjugated, :tense, :sub_type, type: "conjugated"]
end
