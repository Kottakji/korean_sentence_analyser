defmodule KoreanSentenceAnalyser.DataTypes.Modifier do
  alias KoreanSentenceAnalyser.Helpers.Dict
  
  def remove(word) do
    result = word
             |> Dict.find_beginning_in_file("data/substantives/modifier.txt")
    
    case result do
      nil -> word
      match ->
        Regex.replace(Regex.compile!("^" <> match, "u"), word, "")
    end
  
  end
end
