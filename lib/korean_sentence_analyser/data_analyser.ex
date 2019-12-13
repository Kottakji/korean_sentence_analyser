defmodule KoreanSentenceAnalyser.DataAnalyser do
  alias KoreanSentenceAnalyser.Normalize
  alias KoreanSentenceAnalyser.Stem
  
  @doc """
  Normalizes a verb/adjective
  Turn 해요 into 하 etc
  """
  def normalize(word) do
    Normalize.normalize(word)
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
  
  @doc """
  Find a word in a file
  """
  def find_in_file(word, file) do
    File.read!(file)
    |> String.split("\n")
    |> Enum.find(fn x -> x == word end)
  end
  
  @doc """
  Add an ending to a word
  In case no word is found, we return nil
  """
  def add_ending(word, ending) do
    case word do
      nil -> nil
      word -> word <> ending
    end
  end
  
  @doc """
  Print the result in token format
  Or nil if nothing is found
  """
  def print_result(value, type, specific_type) do
    case value do
      nil -> nil
      value -> %{"token" => value, "type" => type, "specific_type" => specific_type}
    end
  end
  
  @doc """
  Try to find a word (recursive)
  In case we find a word, we return the result
  In case we do not find a word, we normalize the word and try again (normalize = remove eomi)
  If we can't normalize anymore, we try to stem it and if that doesn't work we return the word (stem = use unicode to find base)
  """
  def find_recursive_with_normalize(file, word, data_type) do
    case find_in_file(word, file) do
      nil ->
        new_word = normalize(word)
        cond do
          new_word == "" ->
            # Stop when the string is emptied
            nil
          new_word == word ->
            # It's the same one, do not keep looking for a word
            # We can try the stem as a final resort
            IO.inspect word
            IO.inspect stem(word)
            
            word
            |> stem
            |> find_in_file(file)
            |> add_ending("다")
            |> print_result(data_type, data_type)
          true ->
            # Keep trying to find a word,
            find_recursive_with_normalize(file, new_word, data_type)
        end
      word ->
        word
        |> add_ending("다")
        |> print_result(data_type, data_type)
    end
  end
end
