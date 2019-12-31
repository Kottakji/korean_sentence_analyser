defmodule KSA.Noun do
  @moduledoc false

  @data_type "Noun"

  @doc """
  Find if the word is a noun

      iex> KSA.Noun.find("단발")
      %{"specific_type" => "Fashion", "token" => "단발", "type" => "Noun"}
    
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
    with nil <- bible(word, :remove_josa),
         nil <- brand(word, :remove_josa),
         nil <- company_name(word, :remove_josa),
         nil <- congress(word, :remove_josa),
         nil <- entity(word, :remove_josa),
         nil <- fashion(word, :remove_josa),
         nil <- foreign(word, :remove_josa),
         nil <- geolocation(word, :remove_josa),
         nil <- kpop(word, :remove_josa),
         nil <- lol(word, :remove_josa),
         nil <- name(word, :remove_josa),
         nil <- neologism(word, :remove_josa),
         nil <- nouns(word, :remove_josa),
         nil <- pokemon(word, :remove_josa),
         nil <- profane(word, :remove_josa),
         nil <- slang(word, :remove_josa),
         nil <- spam(word, :remove_josa),
         nil <- twitter(word, :remove_josa),
         nil <- wikipedia_title_noun(word, :remove_josa),
         do: nil
  end

  @doc """
  Find if the word is a noun, removing any determiner attached to the word
  """
  def find_without_determiner(word) do
    with nil <- bible(word, :remove_determiner),
         nil <- brand(word, :remove_determiner),
         nil <- company_name(word, :remove_determiner),
         nil <- congress(word, :remove_determiner),
         nil <- entity(word, :remove_determiner),
         nil <- fashion(word, :remove_determiner),
         nil <- foreign(word, :remove_determiner),
         nil <- geolocation(word, :remove_determiner),
         nil <- kpop(word, :remove_determiner),
         nil <- lol(word, :remove_determiner),
         nil <- name(word, :remove_determiner),
         nil <- neologism(word, :remove_determiner),
         nil <- nouns(word, :remove_determiner),
         nil <- pokemon(word, :remove_determiner),
         nil <- profane(word, :remove_determiner),
         nil <- slang(word, :remove_determiner),
         nil <- spam(word, :remove_determiner),
         nil <- twitter(word, :remove_determiner),
         nil <- wikipedia_title_noun(word, :remove_determiner) do
      nil
    else
      match = %{"token" => token} ->
        [
          KSA.Formatter.print_result(KSA.Word.get_remaining(word, token), "Determiner"),
          match
        ]
    end
  end

  @doc """
  Find if the word is a noun, removing any grammar attached to the word
  """
  def find_without_grammar(word) do
    with nil <- bible(word, :remove_grammar),
         nil <- brand(word, :remove_grammar),
         nil <- company_name(word, :remove_grammar),
         nil <- congress(word, :remove_grammar),
         nil <- entity(word, :remove_grammar),
         nil <- fashion(word, :remove_grammar),
         nil <- foreign(word, :remove_grammar),
         nil <- geolocation(word, :remove_grammar),
         nil <- kpop(word, :remove_grammar),
         nil <- lol(word, :remove_grammar),
         nil <- name(word, :remove_grammar),
         nil <- neologism(word, :remove_grammar),
         nil <- nouns(word, :remove_grammar),
         nil <- pokemon(word, :remove_grammar),
         nil <- profane(word, :remove_grammar),
         nil <- slang(word, :remove_grammar),
         nil <- spam(word, :remove_grammar),
         nil <- twitter(word, :remove_grammar),
         nil <- wikipedia_title_noun(word, :remove_grammar),
         do: nil
  end

  @doc """
  Find if the word is a bible word
  """
  def bible(word, option \\ nil) do
    KSA.LocalDict.find_in_file(word, "noun/bible.txt", option)
    |> KSA.Formatter.print_result(@data_type, "Bible")
  end

  @doc """
  Find if the word is a brand name
  """
  def brand(word, option \\ nil) do
    KSA.LocalDict.find_in_file(word, "noun/brand.txt", option)
    |> KSA.Formatter.print_result(@data_type, "Brand")
  end

  @doc """
  Find if the word is a company name
  """
  def company_name(word, option \\ nil) do
    KSA.LocalDict.find_in_file(word, "noun/company_names.txt", option)
    |> KSA.Formatter.print_result(@data_type, "Company name")
  end

  @doc """
  Find if the word is the name of a congress
  """
  def congress(word, option \\ nil) do
    KSA.LocalDict.find_in_file(word, "noun/congress.txt", option)
    |> KSA.Formatter.print_result(@data_type, "Congress")
  end

  @doc """
  Find if the word is an entity
  """
  def entity(word, option \\ nil) do
    KSA.LocalDict.find_in_file(word, "noun/entities.txt", option)
    |> KSA.Formatter.print_result(@data_type, "Entities")
  end

  @doc """
  Find if the word is a fashion name
  """
  def fashion(word, option \\ nil) do
    KSA.LocalDict.find_in_file(word, "noun/fashion.txt", option)
    |> KSA.Formatter.print_result(@data_type, "Fashion")
  end

  @doc """
  Find if the word is a foreign name
  """
  def foreign(word, option \\ nil) do
    KSA.LocalDict.find_in_file(word, "noun/foreign.txt", option)
    |> KSA.Formatter.print_result(@data_type, "Foreign")
  end

  @doc """
  Find if the word is a location name
  """
  def geolocation(word, option \\ nil) do
    KSA.LocalDict.find_in_file(word, "noun/geolocations.txt", option)
    |> KSA.Formatter.print_result(@data_type, "Geolocation")
  end

  @doc """
  Find if the word is a k-pop name
  """
  def kpop(word, option \\ nil) do
    KSA.LocalDict.find_in_file(word, "noun/kpop.txt", option)
    |> KSA.Formatter.print_result(@data_type, "K-pop")
  end

  @doc """
  Find if the word is a league of legends (game) name
  """
  def lol(word, option \\ nil) do
    KSA.LocalDict.find_in_file(word, "noun/lol.txt", option)
    |> KSA.Formatter.print_result(@data_type, "Lol")
  end

  @doc """
  Find if the word is a name
  """
  def name(word, option \\ nil) do
    KSA.LocalDict.find_in_file(word, "noun/names.txt", option)
    |> KSA.Formatter.print_result(@data_type, "Name")
  end

  @doc """
  Find if the word is a neologism (recent word, not yet official)
  """
  def neologism(word, option \\ nil) do
    KSA.LocalDict.find_in_file(word, "noun/neologism.txt", option)
    |> KSA.Formatter.print_result(@data_type, "Neologism")
  end

  @doc """
  Find if the word is a general noun
  """
  def nouns(word, option \\ nil) do
    KSA.LocalDict.find_in_file(word, "noun/nouns.txt", option)
    |> KSA.Formatter.print_result(@data_type, "Noun")
  end

  @doc """
  Find if the word is a Pokemon word
  """
  def pokemon(word, option \\ nil) do
    KSA.LocalDict.find_in_file(word, "noun/pokemon.txt", option)
    |> KSA.Formatter.print_result(@data_type, "Pokemon")
  end

  @doc """
  Find if the word is a profane word
  """
  def profane(word, option \\ nil) do
    KSA.LocalDict.find_in_file(word, "noun/profane.txt", option)
    |> KSA.Formatter.print_result(@data_type, "Profane")
  end

  @doc """
  Find if the word is slang
  """
  def slang(word, option \\ nil) do
    KSA.LocalDict.find_in_file(word, "noun/slangs.txt", option)
    |> KSA.Formatter.print_result(@data_type, "Slang")
  end

  @doc """
  Find if the word is spam
  """
  def spam(word, option \\ nil) do
    KSA.LocalDict.find_in_file(word, "noun/spam.txt", option)
    |> KSA.Formatter.print_result(@data_type, "Spam")
  end

  @doc """
  Find if the word is a twitter word
  """
  def twitter(word, option \\ nil) do
    KSA.LocalDict.find_in_file(word, "noun/twitter.txt", option)
    |> KSA.Formatter.print_result(@data_type, "Twitter")
  end

  @doc """
  Find if the word is a wikipedia title
  """
  def wikipedia_title_noun(word, option \\ nil) do
    KSA.LocalDict.find_in_file(word, "noun/wikipedia_title_nouns.txt", option)
    |> KSA.Formatter.print_result(@data_type, "Wikipedia title noun")
  end
end
