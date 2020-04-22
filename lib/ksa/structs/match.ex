defmodule Ksa.Structs.Match do
  @moduledoc """
  Defines a match
  A match contains a child struct with a specific type
  """

  @type t :: %{child: map, rating: integer}

  @enforce_keys [:child, :rating]
  defstruct [:child, :rating]
end
