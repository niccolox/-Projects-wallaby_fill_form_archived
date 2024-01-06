defmodule WallabyFillForm.Mixfile do
  use Mix.Project

  def project do
    [
      app: :wallaby_fill_form,
      version: "0.1.0",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env),
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      package: package(),
      docs: docs(),
    ]
  end


  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.16", only: :dev},
      {:phoenix_html, "~> 2.10"},
      {:wallaby, "~> 0.19"},
    ]
  end

  defp package do
    [
      description: "Simplify form filling with Wallaby",
      maintainers: ["Josh Steiner"],
      licenses: ["MIT"],
      links: %{
        "Docs" => "https://hexdocs.pm/wallaby_fill_form/",
        "GitHub" => "https://github.com/thoughtbot/wallaby_fill_form",
        "Made by thoughtbot" => "https://thoughtbot.com/services/elixir-phoenix",
      },
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: ["README.md"],
    ]
  end
end
