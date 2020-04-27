defmodule Ksa do
  @moduledoc """
  Analyse Korean text
  """
  use Application
  alias Ksa.Structs.{Adjective, Verb}
  
  @doc false
  def start(_type, _args) do
    Ksa.Ets.DictFile.init()
    Supervisor.start_link([], strategy: :one_for_one)
  end
  
  @doc """
  Analyse a sentence
  
      iex> Ksa.analyse("저는 공부하느라고 청소를 못 했어요")
      [
        %{"공부하느라고" => "공부"},
        %{"못" => "못"},
        %{"저는" => "저"},
        %{"청소를" => "청소"},
        %{"했어요" => "하다"}
      ]
  """
  @spec analyse(String.t()) :: list
  def analyse(sentence) when is_bitstring(sentence) do
    sentence
    |> analyse_verbose
    |> filter
  end
  
  @doc """
  Analyse a sentence and return it's type
  
      iex> Ksa.analyse_with_type("저는 공부하느라고 청소를 못 했어요")
      [
        %{"공부하느라고" => {"noun", "공부"}},
        %{"못" => {"noun", "못"}},
        %{"저는" => {"noun", "저"}},
        %{"청소를" => {"noun", "청소"}},
        %{"했어요" => {"verb", "하다"}}
      ]
  """
  @spec analyse_with_type(String.t()) :: list
  def analyse_with_type(sentence) when is_bitstring(sentence) do
    sentence
    |> analyse_verbose
    |> filter_with_type
  end
  
  @doc """
  Analyse a sentence and give verbose output\n
  You need to create your own filter
  """
  @spec analyse_verbose(String.t()) :: list
  def analyse_verbose(sentence) when is_bitstring(sentence) do
    case String.match?(sentence, ~r/^[가-힣| ]+$/) do
      true -> [
                Ksa.DataTypes.Adjective.match(sentence),
                Ksa.DataTypes.Adverb.match(sentence),
                Ksa.DataTypes.Auxiliary.match(sentence),
                Ksa.DataTypes.Noun.match(sentence),
                Ksa.DataTypes.Substantive.match(sentence),
                Ksa.DataTypes.Verb.match(sentence)
              ]
              |> Enum.concat()
              |> Ksa.Analyse.analyse()
              |> Enum.sort(&(&1.rating >= &2.rating))
      false -> []
    end
  end
  
  @spec filter(list) :: list
  defp filter(matches) when is_list(matches) do
    matches
    |> Enum.group_by(fn x -> x.child.word end)
    |> Enum.map(
         fn {key, matches} ->
           max = Enum.max_by(matches, fn x -> x.rating end)
        
           case max.child do
             %Verb{match: match} ->
               %{key => match <> "다"}
          
             %Adjective{match: match} ->
               %{key => match <> "다"}
          
             child ->
               %{key => child.match}
           end
         end
       )
  end
  
  @spec filter_with_type(list) :: list
  defp filter_with_type(matches) when is_list(matches) do
    matches
    |> Enum.group_by(fn x -> x.child.word end)
    |> Enum.map(
         fn {key, matches} ->
           max = Enum.max_by(matches, fn x -> x.rating end)
        
           case max.child do
             %Verb{match: match, type: type} ->
               %{key => {type, match <> "다"}}
          
             %Adjective{match: match, type: type} ->
               %{key => {type, match <> "다"}}
          
             child ->
               %{key => {child.type, child.match}}
           end
         end
       )
  end
end
