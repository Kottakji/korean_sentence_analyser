defmodule KoreanSentenceAnalyser.DataTypes.Noun do
  alias KoreanSentenceAnalyser.DataTypes.Josa
  alias KoreanSentenceAnalyser.Helpers.Dict
  alias KoreanSentenceAnalyser.Helpers.Formatter
  @data_type "Noun"

  def bible(word, remove_josa \\ false) do
    find(word, "data/noun/bible.txt", "Bible", remove_josa)
  end

  def brand(word, remove_josa \\ false) do
    find(word, "data/noun/brand.txt", "Brand", remove_josa)
  end

  def company_name(word, remove_josa \\ false) do
    find(word, "data/noun/company_names.txt", "Company name", remove_josa)
  end

  def congress(word, remove_josa \\ false) do
    find(word, "data/noun/congress.txt", "Congress", remove_josa)
  end

  def entity(word, remove_josa \\ false) do
    find(word, "data/noun/entities.txt", "Entities", remove_josa)
  end

  def fashion(word, remove_josa \\ false) do
    find(word, "data/noun/fashion.txt", "Fashion", remove_josa)
  end

  def foreign(word, remove_josa \\ false) do
    find(word, "data/noun/foreign.txt", "Foreign", remove_josa)
  end

  def geolocation(word, remove_josa \\ false) do
    find(word, "data/noun/geolocations.txt", "Geolocation", remove_josa)
  end

  def kpop(word, remove_josa \\ false) do
    find(word, "data/noun/kpop.txt", "K-pop", remove_josa)
  end

  def lol(word, remove_josa \\ false) do
    find(word, "data/noun/lol.txt", "Lol", remove_josa)
  end

  def name(word, remove_josa \\ false) do
    find(word, "data/noun/names.txt", "Name", remove_josa)
  end

  def neologism(word, remove_josa \\ false) do
    find(word, "data/noun/neologism.txt", "Neologism", remove_josa)
  end

  def nouns(word, remove_josa \\ false) do
    find(word, "data/noun/nouns.txt", "Noun", remove_josa)
  end

  def pokemon(word, remove_josa \\ false) do
    find(word, "data/noun/pokemon.txt", "Pokemon", remove_josa)
  end

  def profane(word, remove_josa \\ false) do
    find(word, "data/noun/profane.txt", "Profane", remove_josa)
  end

  def slang(word, remove_josa \\ false) do
    find(word, "data/noun/slangs.txt", "Slang", remove_josa)
  end

  def spam(word, remove_josa \\ false) do
    find(word, "data/noun/spam.txt", "Spam", remove_josa)
  end

  def twitter(word, remove_josa \\ false) do
    find(word, "data/noun/twitter.txt", "Twitter", remove_josa)
  end

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
