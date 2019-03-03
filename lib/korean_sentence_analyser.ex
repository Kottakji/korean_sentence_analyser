defmodule KoreanSentenceAnalyser do
  @url "http://localhost:9200/_analyze"
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
          "end_offset" => 3,
          "position" => 0,
          "start_offset" => 0,
          "token" => "한국어",
          "type" => "Noun"
        },
        %{
          "end_offset" => 8,
          "position" => 1,
          "start_offset" => 4,
          "token" => "배우다",
          "type" => "Verb"
        },
        %{
          "end_offset" => 14,
          "position" => 2,
          "start_offset" => 9,
          "token" => "재미있다",
          "type" => "Adjective"
        }
      ]
      }
  """
  def analyse_sentence(sentence) do
    HTTPoison.start
    body = Jason.encode!(%{"analyzer" => "openkoreantext-analyzer", "text" => sentence})
    {:ok, response} = HTTPoison.post @url, body, @headers

    case Jason.decode!(response.body) do
      %{"tokens" => []} -> nil # Return nil on empty
      tokens -> tokens
    end
  end

  @doc """
  Analyse a single word
  Returns a string with the stem, or nil if empty

      iex> KoreanSentenceAnalyser.get_the_stem_of_a_word("완벽했지")
      "완벽하다"
  """
  def get_the_stem_of_a_word(word) do
    HTTPoison.start
    body = Jason.encode!(%{"analyzer" => "openkoreantext-analyzer", "text" => word})
    {:ok, response} = HTTPoison.post @url, body, @headers

    case Jason.decode!(response.body) do
      %{"tokens" => [token_map]} -> token_map["token"]
      %{"tokens" => []} -> nil
    end
  end
end
