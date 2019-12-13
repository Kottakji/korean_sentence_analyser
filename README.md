# KoreanSentenceAnalyser

[![Build Status](https://travis-ci.org/JorisKok/korean_sentence_analyser.svg?branch=master)](https://travis-ci.org/JorisKok/korean_sentence_analyser)
[![Hex pm](http://img.shields.io/hexpm/v/korean_sentence_analyser.svg?style=flat)](https://hex.pm/packages/korean_sentence_analyser)

Docs: [https://hexdocs.pm/korean_sentence_analyser](https://hexdocs.pm/korean_sentence_analyser).

Note: Currently integrating native Elixir support for this package (instead of relying on a python Docker image)GG. You can find the Docker files here:
https://github.com/JorisKok/korean_sentence_analyser/blob/3391529b369f042cfd916d2a2c8f79f2c2d72c92/Dockerfile
https://github.com/JorisKok/korean_sentence_analyser/blob/3391529b369f042cfd916d2a2c8f79f2c2d72c92/docker-compose.yml

## How to use

Add to mix.exs

```elixir
def deps do
  [
    {:korean_sentence_analyser, "~> 0.1.4"}
  ]
end
```

Start the python flask interface (mini api)

```docker-compose up -d```

##### For sentence analysis
```elixir
KoreanSentenceAnalyser.analyse_sentence("한국어 배우기가 재미있어용")

```
Which will return a map, or nil if nothing is found
```elixir
%{
    "tokens" => [
        %{"token" => "한국어", "type" => "Noun"},
        %{"token" => "배우다", "type" => "Verb"},
        %{"token" => "재미있다", "type" => "Adjective"}
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

#### KoNLPy

Docs can be found at http://konlpy.org/en/latest/api

#### Debugging

Turn on debug=True in `app.py`

####  Note: Elasticsearch version

If you want to use the elasticsearch version, use the 1.0.0 tagged release on github, and 0.1.1 on Hex.pm

