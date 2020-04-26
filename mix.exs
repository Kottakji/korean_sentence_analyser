defmodule Ksa.MixProject do
  use Mix.Project

  def project do
    [
      app: :ksa,
      version: "0.4.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test, "coveralls.detail": :test, "coveralls.post": :test, "coveralls.html": :test],
      description: description(),
      package: package(),

      # Docs
      name: "Korean Sentence Analyser",
      source_url: "https://github.com/JorisKok/korean_sentence_analyser",
      docs: [
        main: "Ksa",
        groups_for_modules: [
          Main: [Ksa],
          Special: [
            Ksa.Structs.Match,
            Ksa.Structs.Conjugated
          ],
          Types: [
            Ksa.Structs.Adjective,
            Ksa.Structs.Adverb,
            Ksa.Structs.Auxiliary,
            Ksa.Structs.Noun,
            Ksa.Structs.Substantive,
            Ksa.Structs.Verb
          ]
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
      mod: {Ksa, []},
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
      {:inch_ex, github: "rrrene/inch_ex", only: [:dev, :test]},
      {:excoveralls, "~> 0.10", only: :test}
    ]
  end
end
