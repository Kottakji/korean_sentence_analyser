# KoreanSentenceAnalyser

[![Build Status](https://travis-ci.org/JorisKok/korean_sentence_analyser.svg?branch=master)](https://travis-ci.org/JorisKok/korean_sentence_analyser)
[![Hex pm](http://img.shields.io/hexpm/v/korean_sentence_analyser.svg?style=flat)](https://hex.pm/packages/korean_sentence_analyser)

Docs: [https://hexdocs.pm/chinese_dictionary](https://hexdocs.pm/korean_sentence_analyser).

## How to use

Add to mix.exs

```elixir
def deps do
  [
    {:korean_sentence_analyser, "~> 0.1.0"}
  ]
end
```

Start elastic search via docker compose

```docker-compose up -d```

You can use the dockerfile and docker compose file in this project, and start it however you like.
Just note that the `version of elasticsearch` has to be `6.1.1`


##### For sentence analysis
```elixir
KoreanSentenceAnalyser.analyse_sentence("한국어 배우기가 재미있어용")

```
Which will return a map, or nil if nothing is found
```elixir
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
```

##### For a single word analysis
```elixir
KoreanSentenceAnalyser.get_the_stem_of_a_word("완벽했지")
```

which will return a string, or nil if empty
```elixir
"완벽하다"
```

## Troubleshooting

In case Elasticsearch shuts down because of not enough virtual memory

```sudo sysctl -w vm.max_map_count=262144```

