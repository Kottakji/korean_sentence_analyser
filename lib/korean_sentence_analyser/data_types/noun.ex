defmodule KoreanSentenceAnalyser.DataTypes.Noun do
  @moduledoc false
  
  alias KoreanSentenceAnalyser.Helpers.Dict
  alias KoreanSentenceAnalyser.Helpers.Formatter
  @data_type "Noun"

  @doc """
  Find if the word is a noun
  """
  def find(word) do
    with nil <- bible(word),
         nil <- brand(word),
         nil <- company_name(word),
         nil <- congress(word),
         nil <- entity(word),
         nil <- fashion(word),
         nil <- foreign(word),
         nil <- geolocation(word),
         nil <- kpop(word),
         nil <- lol(word),
         nil <- name(word),
         nil <- neologism(word),
         nil <- nouns(word),
         nil <- pokemon(word),
         nil <- profane(word),
         nil <- slang(word),
         nil <- spam(word),
         nil <- twitter(word),
         nil <- wikipedia_title_noun(word),
         do: nil
  end

  @doc """
  Find if the word is a noun, removing any Josa (grammar) attached to the word
  """
  def find_without_josa(word) do
    with nil <- bible(word, true),
         nil <- brand(word, true),
         nil <- company_name(word, true),
         nil <- congress(word, true),
         nil <- entity(word, true),
         nil <- fashion(word, true),
         nil <- foreign(word, true),
         nil <- geolocation(word, true),
         nil <- kpop(word, true),
         nil <- lol(word, true),
         nil <- name(word, true),
         nil <- neologism(word, true),
         nil <- nouns(word, true),
         nil <- pokemon(word, true),
         nil <- profane(word, true),
         nil <- slang(word, true),
         nil <- spam(word, true),
         nil <- twitter(word, true),
         nil <- wikipedia_title_noun(word, true),
         do: nil
  end

  @doc """
  Find if the word is a bible word
  """
  def bible(word, remove_josa \\ false) do
    Dict.find_in_file(word, "data/noun/bible.txt", remove_josa)
    |> Formatter.print_result(@data_type, "Bible")
  end

  @doc """
  Find if the word is a brand name
  """
  def brand(word, remove_josa \\ false) do
    Dict.find_in_file(word, "data/noun/brand.txt", remove_josa)
    |> Formatter.print_result(@data_type, "Brand")
  end

  @doc """
  Find if the word is a company name
  """
  def company_name(word, remove_josa \\ false) do
    Dict.find_in_file(word, "data/noun/company_names.txt", remove_josa)
    |> Formatter.print_result(@data_type, "Company name")
  end

  @doc """
  Find if the word is the name of a congress
  """
  def congress(word, remove_josa \\ false) do
    Dict.find_in_file(word, "data/noun/congress.txt", remove_josa)
    |> Formatter.print_result(@data_type, "Congress")
  end

  @doc """
  Find if the word is an entity
  """
  def entity(word, remove_josa \\ false) do
    Dict.find_in_file(word, "data/noun/entities.txt", remove_josa)
    |> Formatter.print_result(@data_type, "Entities")
  end

  @doc """
  Find if the word is a fashion name
  """
  def fashion(word, remove_josa \\ false) do
    Dict.find_in_file(word, "data/noun/fashion.txt", remove_josa)
    |> Formatter.print_result(@data_type, "Fashion")
  end

  @doc """
  Find if the word is a foreign name
  """
  def foreign(word, remove_josa \\ false) do
    Dict.find_in_file(word, "data/noun/foreign.txt", remove_josa)
    |> Formatter.print_result(@data_type, "Foreign")
  end

  @doc """
  Find if the word is a location name
  """
  def geolocation(word, remove_josa \\ false) do
    Dict.find_in_file(word, "data/noun/geolocations.txt", remove_josa)
    |> Formatter.print_result(@data_type, "Geolocation")
  end

  @doc """
  Find if the word is a k-pop name
  """
  def kpop(word, remove_josa \\ false) do
    Dict.find_in_file(word, "data/noun/kpop.txt", remove_josa)
    |> Formatter.print_result(@data_type, "K-pop")
  end

  @doc """
  Find if the word is a league of legends (game) name
  """
  def lol(word, remove_josa \\ false) do
    Dict.find_in_file(word, "data/noun/lol.txt", remove_josa)
    |> Formatter.print_result(@data_type, "Lol")
  end

  @doc """
  Find if the word is a name
  """
  def name(word, remove_josa \\ false) do
    Dict.find_in_file(word, "data/noun/names.txt", remove_josa)
    |> Formatter.print_result(@data_type, "Name")
  end

  @doc """
  Find if the word is a neologism (recent word, not yet official)
  """
  def neologism(word, remove_josa \\ false) do
    Dict.find_in_file(word, "data/noun/neologism.txt", remove_josa)
    |> Formatter.print_result(@data_type, "Neologism")
  end

  @doc """
  Find if the word is a general noun
  """
  def nouns(word, remove_josa \\ false) do
    Dict.find_in_file(word, "data/noun/nouns.txt", remove_josa)
    |> Formatter.print_result(@data_type, "Noun")
  end

  @doc """
  Find if the word is a Pokemon word
  """
  def pokemon(word, remove_josa \\ false) do
    Dict.find_in_file(word, "data/noun/pokemon.txt", remove_josa)
    |> Formatter.print_result(@data_type, "Pokemon")
  end

  @doc """
  Find if the word is a profane word
  """
  def profane(word, remove_josa \\ false) do
    Dict.find_in_file(word, "data/noun/profane.txt", remove_josa)
    |> Formatter.print_result(@data_type, "Profane")
  end

  @doc """
  Find if the word is slang
  """
  def slang(word, remove_josa \\ false) do
    Dict.find_in_file(word, "data/noun/slangs.txt", remove_josa)
    |> Formatter.print_result(@data_type, "Slang")
  end

  @doc """
  Find if the word is spam
  """
  def spam(word, remove_josa \\ false) do
    Dict.find_in_file(word, "data/noun/spam.txt", remove_josa)
    |> Formatter.print_result(@data_type, "Spam")
  end

  @doc """
  Find if the word is a twitter word
  """
  def twitter(word, remove_josa \\ false) do
    Dict.find_in_file(word, "data/noun/twitter.txt", remove_josa)
    |> Formatter.print_result(@data_type, "Twitter")
  end

  @doc """
  Find if the word is a wikipedia title
  """
  def wikipedia_title_noun(word, remove_josa \\ false) do
    Dict.find_in_file(word, "data/noun/wikipedia_title_nouns.txt", remove_josa)
    |> Formatter.print_result(@data_type, "Wikipedia title noun")
  end
end
