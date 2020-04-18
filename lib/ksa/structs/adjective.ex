defmodule Ksa.Structs.Noun do
  @moduledoc """
  Defines the noun
  서울은 is the word given, the part matched is 서울
  """
  @enforce_keys [:word, :part, :subtype]
  defstruct [:word, :part, :subtype, type: "noun"]
end
