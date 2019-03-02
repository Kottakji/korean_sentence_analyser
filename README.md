# KoreanSentenceAnalyser


## Usage

Add to mix.exs

```elixir
def deps do
  [
    {:korean_sentence_analyser, "~> 0.1.0"}
  ]
end
```


## Troubleshooting

In case Elasticsearch shuts down because of not enough virtual memory

```sudo sysctl -w vm.max_map_count=262144```

