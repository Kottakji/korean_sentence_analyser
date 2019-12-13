defmodule KoreanSentenceAnalyser.DataTypes.Adjective do
  import KoreanSentenceAnalyser.DataAnalyser
  @data_type "Adjective"

  def adjective(word) do
    # TODO we just need to remove the josa from the end, and see if we have a result
    # TODO else we need to recursively normalize
    # TODO then we can remove stem.ex
    # TODO refactor
    find_recursive_with_normalize("data/adjective/adjective.txt", word, @data_type)
  end
end
