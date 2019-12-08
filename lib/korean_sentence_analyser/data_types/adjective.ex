defmodule KoreanSentenceAnalyser.DataTypes.Adjective do
  import KoreanSentenceAnalyser.DataAnalyser
  @data_type "Adjective"

  def adjective(word) do
    find_recursive_with_normalize("data/adjective/adjective.txt", word, @data_type)
  end
end
