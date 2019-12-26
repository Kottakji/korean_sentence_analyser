defmodule KoreanSentenceAnalyser.DataTypes.Noun do
  alias KoreanSentenceAnalyser.DataTypes.Josa
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
    find(word, "data/noun/bible.txt", "Bible", remove_josa)
  end

  @doc """
  Find if the word is a brand name
  """
  def brand(word, remove_josa \\ false) do
    find(word, "data/noun/brand.txt", "Brand", remove_josa)
  end

  @doc """
  Find if the word is a company name
  """
  def company_name(word, remove_josa \\ false) do
    find(word, "data/noun/company_names.txt", "Company name", remove_josa)
  end

  @doc """
  Find if the word is the name of a congress
  """
  def congress(word, remove_josa \\ false) do
    find(word, "data/noun/congress.txt", "Congress", remove_josa)
  end

  @doc """
  Find if the word is an entity
  """
  def entity(word, remove_josa \\ false) do
    find(word, "data/noun/entities.txt", "Entities", remove_josa)
  end

  @doc """
  Find if the word is a fashion name
  """
  def fashion(word, remove_josa \\ false) do
    find(word, "data/noun/fashion.txt", "Fashion", remove_josa)
  end

  @doc """
  Find if the word is a foreign name
  """
  def foreign(word, remove_josa \\ false) do
    find(word, "data/noun/foreign.txt", "Foreign", remove_josa)
  end

  @doc """
  Find if the word is a location name
  """
  def geolocation(word, remove_josa \\ false) do
    find(word, "data/noun/geolocations.txt", "Geolocation", remove_josa)
  end

  @doc """
  Find if the word is a kpop name
  """
  def kpop(word, remove_josa \\ false) do
    find(word, "data/noun/kpop.txt", "K-pop", remove_josa)
  end

  @doc """
  Find if the word is a league of legends (game) name
  """
  def lol(word, remove_josa \\ false) do
    find(word, "data/noun/lol.txt", "Lol", remove_josa)
  end

  @doc """
  Find if the word is a name
  """
  def name(word, remove_josa \\ false) do
    find(word, "data/noun/names.txt", "Name", remove_josa)
  end

  @doc """
  Find if the word is a neologism (recent word, not yet official)
  """
  def neologism(word, remove_josa \\ false) do
    find(word, "data/noun/neologism.txt", "Neologism", remove_josa)
  end

  @doc """
  Find if the word is a general noun
  """
  def nouns(word, remove_josa \\ false) do
    find(word, "data/noun/nouns.txt", "Noun", remove_josa)
  end

  @doc """
  Find if the word is a Pokemon word
  """
  def pokemon(word, remove_josa \\ false) do
    find(word, "data/noun/pokemon.txt", "Pokemon", remove_josa)
  end

  @doc """
  Find if the word is a profane word
  """
  def profane(word, remove_josa \\ false) do
    find(word, "data/noun/profane.txt", "Profane", remove_josa)
  end

  @doc """
  Find if the word is slang
  """
  def slang(word, remove_josa \\ false) do
    find(word, "data/noun/slangs.txt", "Slang", remove_josa)
  end

  @doc """
  Find if the word is spam
  """
  def spam(word, remove_josa \\ false) do
    find(word, "data/noun/spam.txt", "Spam", remove_josa)
  end

  @doc """
  Find if the word is a twitter word
  """
  def twitter(word, remove_josa \\ false) do
    find(word, "data/noun/twitter.txt", "Twitter", remove_josa)
  end

  @doc """
  Find if the word is a wikipedia title
  """
  def wikipedia_title_noun(word, remove_josa \\ false) do
    find(word, "data/noun/wikipedia_title_nouns.txt", "Wikipedia title noun", remove_josa)
  end

  defp find(word, file, type, remove_josa) do
    case remove_josa do
      true -> find_with_removing_josa(word, file, type)
      false -> find_basic(word, file, type)
    end
  end

  defp find_basic(word, file, type) do
    word
    |> Dict.find_in_file(file)
    |> Formatter.print_result(@data_type, type)
  end

  defp find_with_removing_josa(word, file, type) do
    word
    |> Josa.remove()
    |> Dict.find_in_file(file)
    |> Formatter.print_result(@data_type, type)
  end
end
