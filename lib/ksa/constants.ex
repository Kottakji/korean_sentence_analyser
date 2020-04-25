defmodule Ksa.Constants do
  @moduledoc false
  defmacro __using__(_) do
    quote do
      # Tenses
      @present_tense "present"
      @present_formal_tense "present_formal"
      @past_tense "past"
      @past_written_tense "past_written"
      @future_tense "future"
      @imperative_tense "imperative"
      @nominal_tense "nominal"
  
      # Sub types
      @regular "regular"
      @irregular "irregular"
      @passive "passive"
    end
  end
end
