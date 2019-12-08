defmodule KoreanSentenceAnalyser.DataTypes.Noun do
  import KoreanSentenceAnalyser.DataAnalyser
  @data_type "Noun"

  def bible(word) do
    find_in_file("data/noun/bible.txt", word)
    |> print_result(@data_type, "Bible")
  end

  def brand(word) do
    find_in_file("data/noun/brand.txt", word)
    |> print_result(@data_type, "Brand")
  end

  def company_name(word) do
    find_in_file("data/noun/company_names.txt", word)
    |> print_result(@data_type, "Company name")
  end

  def congress(word) do
    find_in_file("data/noun/congress.txt", word)
    |> print_result(@data_type, "Congress")
  end

  def entity(word) do
    find_in_file("data/noun/entities.txt", word)
    |> print_result(@data_type, "Entities")
  end

  def fashion(word) do
    find_in_file("data/noun/fashion.txt", word)
    |> print_result(@data_type, "Fashion")
  end

  def foreign(word) do
    find_in_file("data/noun/foreign.txt", word)
    |> print_result(@data_type, "Foreign")
  end

  def geolocation(word) do
    find_in_file("data/noun/geolocations.txt", word)
    |> print_result(@data_type, "Geolocation")
  end

  def kpop(word) do
    find_in_file("data/noun/kpop.txt", word)
    |> print_result(@data_type, "K-pop")
  end

  def lol(word) do
    find_in_file("data/noun/lol.txt", word)
    |> print_result(@data_type, "Lol")
  end

  def name(word) do
    find_in_file("data/noun/names.txt", word)
    |> print_result(@data_type, "Name")
  end

  def neologism(word) do
    find_in_file("data/noun/neologism.txt", word)
    |> print_result(@data_type, "Neologism")
  end

  def nouns(word) do
    find_in_file("data/noun/nouns.txt", word)
    |> print_result(@data_type, "Noun")
  end

  def pokemon(word) do
    find_in_file("data/noun/pokemon.txt", word)
    |> print_result(@data_type, "Pokemon")
  end

  def profane(word) do
    find_in_file("data/noun/profane.txt", word)
    |> print_result(@data_type, "Profane")
  end

  def slang(word) do
    find_in_file("data/noun/slangs.txt", word)
    |> print_result(@data_type, "Slang")
  end

  def spam(word) do
    find_in_file("data/noun/spam.txt", word)
    |> print_result(@data_type, "Spam")
  end

  def twitter(word) do
    find_in_file("data/noun/twitter.txt", word)
    |> print_result(@data_type, "Twitter")
  end

  def wikipedia_title_noun(word) do
    find_in_file("data/noun/wikipedia_title_nouns.txt", word)
    |> print_result(@data_type, "Wikipedia title noun")
  end
end
