defmodule Ksa.Structs.Match do
  @moduledoc """
  Defines a match\n
  A match contains a child with a struct
  """

  @type child :: Ksa.Structs.Adjective | Ksa.Structs.Adverb | Ksa.Structs.Auxiliary | Ksa.Structs.Noun | Ksa.Structs.Substantive | Ksa.Structs.Verb
  @type t :: %{child: child, rating: float}

  @enforce_keys [:child, :rating]
  defstruct [:child, :rating]
end
