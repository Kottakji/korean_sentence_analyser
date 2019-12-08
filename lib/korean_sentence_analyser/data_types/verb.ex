defmodule KoreanSentenceAnalyser.DataTypes.Verb do
  import KoreanSentenceAnalyser.DataAnalyser
  @data_type "Verb"
  
  def verb(word) do
    find_recursive_with_normalize("data/verb/verb.txt", word, @data_type)
  end
end
