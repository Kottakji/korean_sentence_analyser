defmodule KoreanSentenceAnalyser.DataAnalyser do
  alias KoreanSentenceAnalyser.DataTypes.Eomi
  alias KoreanSentenceAnalyser.Helpers.Stem
  
  @doc """
  Remove Eomi from the words
  Turn 해요 into 하 etc
  """
  def remove_eomi(word) do
    Eomi.remove(word)
  end

  @doc """
  Removes Eomi recursively
  """
  def remove_eomi_recursively(word, file, data_type) do
    Eomi.remove_recursively(word, file, data_type)
  end
  
  @doc """
  Can remove past/future tense etc
  For example it can help find that 냈(다) is 내
  This method can be destructive
  늘다 can be turned into 느다
  So, always check if the verb/adjective is already valid, before stemming
  """
  def stem(word) do
    Stem.stem(word)
  end
end
