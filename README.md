# KoreanSentenceAnalyser

[![Build Status](https://travis-ci.org/JorisKok/korean_sentence_analyser.svg?branch=master)](https://travis-ci.org/JorisKok/korean_sentence_analyser)
[![Hex pm](http://img.shields.io/hexpm/v/korean_sentence_analyser.svg?style=flat)](https://hex.pm/packages/korean_sentence_analyser)

Docs: [https://hexdocs.pm/korean_sentence_analyser](https://hexdocs.pm/korean_sentence_analyser).


## In short

An attempt to try to get information about Korean text.

Given a sentence or word, this library will give a fairly accurate list of words and information about the type of words.
A type (noun, verb, adjective etc) is returned, as well as a specific type (K-pop, Wikipedia title etc).

All words are returned in the form they appear in the dictionary: 공부하다, 일하다). Thus this can be useful find a dictionary searchable base of a conjugated word.

All modules are documented and can be used individually, but keep in mind that they are build mainly for the sentence_analyse function. Feel free to open a issue on github if you have any questions.

## How to use

Add to mix.exs

```elixir
def deps do
  [
    {:korean_sentence_analyser, "~> 0.3.0"}
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

More helpful functions are available in https://hexdocs.pm/korean_sentence_analyser/KoreanSentenceAnalyser.html on how to deal with Unicode for Hangul.

