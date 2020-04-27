# KoreanSentenceAnalyser

[![Build Status](https://travis-ci.org/JorisKok/korean_sentence_analyser.svg?branch=master)](https://travis-ci.org/JorisKok/korean_sentence_analyser)
[![Hex pm](http://img.shields.io/hexpm/v/korean_sentence_analyser.svg?style=flat)](https://hex.pm/packages/korean_sentence_analyser)

Docs: [https://hexdocs.pm/ksa](https://hexdocs.pm/ksa).


## Analyse Korean Text

An attempt to try to get information about Korean text.

## How to use

Add to mix.exs

```elixir
def deps do
  [
    {:ksa, "~> 0.4.1"}
  ]
end
```

When you just want to get the stem of the words:
```elixir
iex> Ksa.analyse("저는 공부하느라고 청소를 못 했어요")
[
%{"공부하느라고" => "공부"},
%{"못" => "못"},
%{"저는" => "저"},
%{"청소를" => "청소"},
%{"했어요" => "하다"}
]

```
Or if you want to know which type the words are:
```elixir
iex> Ksa.analyse_with_type("저는 공부하느라고 청소를 못 했어요")
[
%{"공부하느라고" => {"noun", "공부"}},
%{"못" => {"noun", "못"}},
%{"저는" => {"noun", "저"}},
%{"청소를" => {"noun", "청소"}},
%{"했어요" => {"verb", "하다"}}
]
```
