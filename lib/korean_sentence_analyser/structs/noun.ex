defmodule KSA.Structs.Noun do
  @moduledoc """
  Defines the noun
  """
  @enforce_keys [:word, :accuracy]
  defstruct [:word, :accuracy, type: "noun"]
end