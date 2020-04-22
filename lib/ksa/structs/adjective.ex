defmodule Ksa.Structs.Adjective do
  @moduledoc """
  Defines the adjective
  """
  
  @type t :: %{
               word: String.t(),
               match: String.t(),
               type: String.t(),
               conjugated: Ksa.Structs.Conjugated.t(),
               base_rating: float,
             }
  
  @enforce_keys [:word, :match]
  defstruct [:word, :match, type: "adjective", conjugated: nil, base_rating: 0.8]
end
