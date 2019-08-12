defmodule KoreanSentenceAnalyser do
  @url "http://localhost:5000/analyse/"
  @headers [{"Content-Type", "application/json"}]
  
  @moduledoc """
  Analyses Korean text
  Returns their stem/base form and additional information, like whether it's a noun
  """
  
  @doc """
  Analyses a sentence
  Returns a Map, or nil if nothing found
  
  Example response
      iex> KoreanSentenceAnalyser.analyse_sentence("한국어 배우기가 재미있어용")
      %{
      "tokens" => [
        %{
          "token" => "한국어",
          "type" => "Noun"
        },
        %{
          "token" => "배우다",
          "type" => "Verb"
        },
        %{
          "token" => "재미있다",
          "type" => "Adjective"
        }
      ]
      }
  """
  def analyse_sentence("") do
    nil
  end
  
  def analyse_sentence(sentence) do
    HTTPoison.start
    %{body: body, status_code: 200} = HTTPoison.get! @url <> URI.encode(sentence), @headers
    
    %{
      "tokens" =>
        Jason.decode!(body)
        |> Enum.map(fn [token, type] -> %{"token" => token, "type" => type} end)
    }
  end
  
  @doc """
  Analyse a single word
  Returns a string with the stem, or nil if empty
  
      iex> KoreanSentenceAnalyser.get_the_stem_of_a_word("완벽했지")
      "완벽하다"
  """
  def get_the_stem_of_a_word("") do
    nil
  end
  
  def get_the_stem_of_a_word(word) do
    HTTPoison.start
    %{body: body, status_code: 200} = HTTPoison.get! @url <> URI.encode(word), @headers
    
    case Jason.decode!(body) do
      [] -> ""
      result when is_list(result) ->
        hd(hd(result))
    end
  end
end
