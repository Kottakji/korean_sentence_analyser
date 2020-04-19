defmodule Ksa.Structs.Adjective do
  @moduledoc """
  Defines the adjective
  """
  @enforce_keys [:word, :part]
  defstruct [:word, :part, type: "adjective"]
end
