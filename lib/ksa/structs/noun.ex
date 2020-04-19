defmodule Ksa.Structs.Noun do
  @moduledoc """
  Defines the noun
  서울은 is the word given, the part matched is 서울
  """

  @type t :: %{word: String.t(), match: String.t(), type: String.t(), subtype: String.t()}

  @enforce_keys [:word, :match, :subtype]
  defstruct [:word, :match, :subtype, type: "noun"]
end
