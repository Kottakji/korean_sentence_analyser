defmodule KSA.Conjunction do
  @moduledoc false
  
  @data_type "Conjunction"
  @file_path "auxiliary/conjunctions.txt"
  
  @doc """
  Find if the word is a conjunction
  
      iex> KSA.Conjunction.find("그럼")
      %{"specific_type" => "Conjunction","token" => "그럼","type" => "Conjunction"}
    
  """
  def find(word) do
    case KSA.LocalDict.find_ending_in_file(word, @file_path) do
      nil -> nil
      match ->
      
      case match == word do
        true ->
          KSA.Formatter.print_result(match, @data_type)
        false ->
          find(word, match)
      end
    end
  end
  
  defp find(word, match) do
    remains = KSA.Word.get_remaining(word, match)
    
    case KSA.Word.find(remains) do
      nil ->
        nil
      remains_match ->
        [
          remains_match,
          KSA.Formatter.print_result(match, @data_type)
        ]
    end
  end
end
