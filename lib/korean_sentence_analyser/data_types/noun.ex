defmodule KoreanSentenceAnalyser.DataTypes.Noun do
  alias KoreanSentenceAnalyser.DataTypes.Josa
  alias KoreanSentenceAnalyser.Helpers.Dict
  alias KoreanSentenceAnalyser.Helpers.Formatter
  @data_type "Noun"
  
  def bible(word) do
    find(word, "data/noun/bible.txt", "Bible")
  end
  
  def brand(word) do
    find(word, "data/noun/brand.txt", "Brand")
  end
  
  def company_name(word) do
    find(word, "data/noun/company_names.txt", "Company name")
  end
  
  def congress(word) do
    find(word, "data/noun/congress.txt", "Congress")
  end
  
  def entity(word) do
    find(word, "data/noun/entities.txt", "Entities")
  end
  
  def fashion(word) do
    find(word, "data/noun/fashion.txt", "Fashion")
  end
  
  def foreign(word) do
    find(word, "data/noun/foreign.txt", "Foreign")
  end
  
  def geolocation(word) do
    find(word, "data/noun/geolocations.txt", "Geolocation")
  end
  
  def kpop(word) do
    find(word, "data/noun/kpop.txt", "K-pop")
  end
  
  def lol(word) do
    find(word, "data/noun/lol.txt", "Lol")
  end
  
  def name(word) do
    find(word, "data/noun/names.txt", "Name")
  end
  
  def neologism(word) do
    find(word, "data/noun/neologism.txt", "Neologism")
  end
  
  def nouns(word) do
    find(word, "data/noun/nouns.txt", "Noun")
  end
  
  def pokemon(word) do
    find(word, "data/noun/pokemon.txt", "Pokemon")
  end
  
  def profane(word) do
    find(word, "data/noun/profane.txt", "Profane")
  end
  
  def slang(word) do
    find(word, "data/noun/slangs.txt", "Slang")
  end
  
  def spam(word) do
    find(word, "data/noun/spam.txt", "Spam")
  end
  
  def twitter(word) do
    find(word, "data/noun/twitter.txt", "Twitter")
  end
  
  def wikipedia_title_noun(word) do
    find(word, "data/noun/wikipedia_title_nouns.txt", "Wikipedia title noun")
  end
  
  defp find(word, file, type) do
    with nil <- find_basic(word, file, type),
         nil <- find_with_removing_josa(word, file, type),
         do: nil
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
