defmodule KoreanSentenceAnalyser.ETS.DictFile do
  @moduledoc """
  Use ETS to access dictionary files
  """
  
  @doc """
  Initiate the dictionaries into ETS
  """
  def init() do
    [
      "data/adjective/adjective.txt",
      "data/adverb/adverb.txt",
      "data/auxiliary/conjunctions.txt",
      "data/auxiliary/determiner.txt",
      "data/auxiliary/exclamation.txt",
      "data/josa/josa.txt",
      "data/noun/bible.txt",
      "data/noun/brand.txt",
      "data/noun/company_names.txt",
      "data/noun/congress.txt",
      "data/noun/entities.txt",
      "data/noun/fashion.txt",
      "data/noun/foreign.txt",
      "data/noun/geolocations.txt",
      "data/noun/kpop.txt",
      "data/noun/lol.txt",
      "data/noun/names.txt",
      "data/noun/neologism.txt",
      "data/noun/nouns.txt",
      "data/noun/pokemon.txt",
      "data/noun/profane.txt",
      "data/noun/slangs.txt",
      "data/noun/spam.txt",
      "data/noun/twitter.txt",
      "data/noun/wikipedia_title_nouns.txt",
      "data/substantives/family_names.txt",
      "data/substantives/given_names.txt",
      "data/substantives/modifier.txt",
      "data/substantives/suffix.txt",
      "data/typos/typos.txt",
      "data/verb/eomi.txt",
      "data/verb/pre_eomi.txt",
      "data/verb/verb.txt",
      "data/verb/verb_prefix.txt"
    ]
    |> Enum.each(fn file -> init_dict_from_file(file) end)
  end
  
  @doc """
  Initiate a dictionary from a file
  """
  def init_dict_from_file(file) when file == "data/typos/typos.txt" do
    :ets.new(String.to_atom(file), [:ordered_set, :protected, :named_table])
    
    File.stream!(file)
    |> Stream.map(
         fn x ->
           [key, value] = String.split(x)
           insert(key, value, file)
         end
       )
    |> Stream.run()
  end
  
  def init_dict_from_file(file) do
    :ets.new(String.to_atom(file), [:ordered_set, :protected, :named_table])
    
    File.stream!(file)
    |> Stream.map(
         fn x ->
           String.replace(x, "\n", "")
           |> insert(file)
         end
       )
    |> Stream.run()
  end
  
  @doc """
  Insert a key and value for a file in the ETS dictionary
  """
  def insert(key, value, file) do
    :ets.insert(String.to_atom(file), {key, value})
  end
  
  @doc """
  Insert a key and value for a file in a the ETS dictionary
  The key will be the same as the value
  """
  def insert(value, file) do
    insert(value, value, file)
  end
  
  @doc """
  Find a word in the dictionary file
  """
  def find(word, file) do
    case :ets.select(String.to_atom(file), [{{word, :_}, [], [:"$_"]}]) do
      [{_key, value}] -> value
      _ -> nil
    end
  end
end
