defmodule DictFile do
  @moduledoc """
  Use ETS to access dictionary files
  """

  @doc """
  Initiate the dictionaries into ETS
  """
  def init() do
    [
      "adjective/adjective.txt",
      "adverb/adverb.txt",
      "auxiliary/conjunctions.txt",
      "auxiliary/determiner.txt",
      "auxiliary/exclamation.txt",
      "josa/josa.txt",
      "noun/bible.txt",
      "noun/brand.txt",
      "noun/company_names.txt",
      "noun/congress.txt",
      "noun/entities.txt",
      "noun/fashion.txt",
      "noun/foreign.txt",
      "noun/geolocations.txt",
      "noun/kpop.txt",
      "noun/lol.txt",
      "noun/names.txt",
      "noun/neologism.txt",
      "noun/nouns.txt",
      "noun/pokemon.txt",
      "noun/profane.txt",
      "noun/slangs.txt",
      "noun/spam.txt",
      "noun/twitter.txt",
      "noun/wikipedia_title_nouns.txt",
      "substantives/family_names.txt",
      "substantives/given_names.txt",
      "substantives/modifier.txt",
      "substantives/suffix.txt",
      "typos/typos.txt",
      "verb/eomi.txt",
      "verb/pre_eomi.txt",
      "verb/verb.txt",
      "verb/verb_prefix.txt"
    ]
    |> Enum.each(fn path -> init_dict_from_file(path) end)
  end

  @doc """
  Initiate a dictionary from a path
  """
  def init_dict_from_file(path) when path == "typos/typos.txt" do
    :ets.new(String.to_atom(path), [:ordered_set, :protected, :named_table])

    Path.join(:code.priv_dir(:korean_sentence_analyser), path)
    |> File.stream!()
    |> Stream.map(fn x ->
      [key, value] = String.split(x)
      insert(key, value, path)
    end)
    |> Stream.run()
  end

  def init_dict_from_file(path) do
    :ets.new(String.to_atom(path), [:ordered_set, :protected, :named_table])

    Path.join(:code.priv_dir(:korean_sentence_analyser), path)
    |> File.stream!()
    |> Stream.map(fn x ->
      String.replace(x, "\n", "")
      |> insert(path)
    end)
    |> Stream.run()
  end

  @doc """
  Insert a key and value for a path in the ETS dictionary
  """
  def insert(key, value, path) do
    :ets.insert(String.to_atom(path), {key, value})
  end

  @doc """
  Insert a key and value for a path in a the ETS dictionary
  The key will be the same as the value
  """
  def insert(value, path) do
    insert(value, value, path)
  end

  @doc """
  Find a word in the dictionary path
  """
  def find(word, path) do
    case :ets.select(String.to_atom(path), [{{word, :_}, [], [:"$_"]}]) do
      [{_key, value}] -> value
      _ -> nil
    end
  end
end
