defmodule KoreanSentenceAnalyser.MixProject do
  use Mix.Project

  def project do
    [
      app: :korean_sentence_analyser,
      version: "0.2.3",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),

      # Docs
      name: "Korean Sentence Analyser",
      source_url: "https://github.com/JorisKok/korean_sentence_analyser",
      docs: [
        main: "KoreanSentenceAnalyser",
        groups_for_modules: [
          Main: [KoreanSentenceAnalyser],
          "Data Types": [Adjective, Adverb, Conjunction, Determiner, Eomi, Josa, ModifiedNoun, Modifier, Noun, PreEomi, Substantive, Verb, VerbPattern],
          ETS: [DictFile],
          Helpers: [Formatter, KoreanUnicode, LocalDict, SplitWord, Stem, Typo, Word]
        ],
        extras: ["README.md"]
      ]
    ]
  end

  defp description do
    "A tool to analyse Korean sentences"
  end

  defp package do
    [
      licenses: ["Apache 2.0"],
      links: %{
        "GitHub" => "https://github.com/JorisKok/korean_sentence_analyser"
      }
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {KoreanSentenceAnalyser, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.4"},
      {:jason, "~> 1.1"},
      # Only :dev
      {:credo, "~> 1.0.0", only: [:dev, :test], runtime: false},
      {:assert_value, ">= 0.0.0", only: [:dev, :test]},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
      {:inch_ex, github: "rrrene/inch_ex", only: [:dev, :test]}
    ]
  end
end
