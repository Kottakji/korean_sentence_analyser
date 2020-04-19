defmodule Ksa.Ets.DictFile do
  @moduledoc """
  Use ETS to access dictionary files
  """

  @doc """
  Initiate the dictionaries into ETS
  """
  @spec init() :: :ok
  def init() do
    [
      "adjective/adjective.txt",
      #      "adverb/adverb.txt",
      #      "auxiliary/conjunctions.txt",
      #      "auxiliary/determiner.txt",
      #      "auxiliary/exclamation.txt",
      #      "grammar/grammar.txt",
      #      "josa/josa.txt",
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
      #      "substantives/family_names.txt",
      #      "substantives/given_names.txt",
      #      "substantives/modifier.txt",
      #      "substantives/suffix.txt",
      #      "typos/typos.txt",
      #      "verb/eomi.txt",
      #      "verb/pre_eomi.txt",
            "verb/verb.txt",
      #      "verb/verb_prefix.txt"
    ]
    |> Enum.each(fn path -> init_dict_from_file(path) end)

    :ok
  end

  @spec init_dict_from_file(String.t()) :: :ok
  defp init_dict_from_file(path) when is_bitstring(path) do
    :ets.new(String.to_atom(path), [:ordered_set, :protected, :named_table])

    Path.join(:code.priv_dir(:ksa), path)
    |> File.stream!()
    |> Stream.map(fn x ->
      String.replace(x, "\n", "")
      |> insert(path)
    end)
    |> Stream.run()

    :ok
  end

  @spec insert(String.t(), String.t(), String.t()) :: :ok
  defp insert(key, value, path) when is_bitstring(key) and is_bitstring(value) and is_bitstring(path) do
    :ets.insert(String.to_atom(path), {key, value})

    :ok
  end

  @spec insert(String.t(), String.t()) :: :ok
  defp insert(value, path) do
    insert(value, value, path)
  end

  @doc """
  Find a word in the dictionary path
  """
  @spec find(String.t(), String.t()) :: nil | String.t()
  def find(word, path) do
    case :ets.select(String.to_atom(path), [{{word, :_}, [], [:"$_"]}]) do
      [{_key, value}] -> value
      _ -> nil
    end
  end
end
