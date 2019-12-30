# KoreanSentenceAnalyser

[![Build Status](https://travis-ci.org/JorisKok/korean_sentence_analyser.svg?branch=master)](https://travis-ci.org/JorisKok/korean_sentence_analyser)
[![Hex pm](http://img.shields.io/hexpm/v/korean_sentence_analyser.svg?style=flat)](https://hex.pm/packages/korean_sentence_analyser)

Docs: [https://hexdocs.pm/korean_sentence_analyser](https://hexdocs.pm/korean_sentence_analyser).

## How to use

Add to mix.exs

```elixir
def deps do
  [
    {:korean_sentence_analyser, "~> 0.2.3"}
  ]
end
```

```elixir
KoreanSentenceAnalyser.analyse_sentence("한국어 배우기가 재미있어용")

```
Which will return a map, or nil if nothing is found
```elixir
[
  %{"specific_type" => "Noun", "token" => "한국어", "type" => "Noun"},
  %{"specific_type" => "Verb", "token" => "배우다", "type" => "Verb"},
  %{
    "specific_type" => "Adjective",
    "token" => "재미있다",
    "type" => "Adjective"
  }
]
```

#### Unicode for Korean

More helpful functions are available in https://hexdocs.pm/korean_sentence_analyser/KoreanUnicode.html on how to deal with Unicode for Hangul.

