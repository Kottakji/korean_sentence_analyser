defmodule KoreanSentenceAnalyser.MixProject do
  use Mix.Project

  def project do
    [
      app: :korean_sentence_analyser,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),

      # Docs
      name: "Korean Sentence Analyser",
      source_url: "https://github.com/JorisKok/korean_sentence_analyser",
      docs: [
        main: "KoreanSentenceAnalyser",
        extras: ["README.md"]
      ],
    ]
  end

  defp description do
    "A tool to analyse Korean sentences\n
     to get the stem/base of the words."
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
