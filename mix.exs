defmodule SprintPoker.Mixfile do
  use Mix.Project

  def project do
    [
      app: :sprint_poker,
      version: "0.5.0",
      elixir: "~> 1.0",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix] ++ Mix.compilers,
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps
   ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [
      mod: {SprintPoker, []},
      applications: ~w(
        phoenix cowboy logger
        phoenix_ecto postgrex
        poison airbrakex
      )a
    ]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [
      {:phoenix, "~> 1.0"},
      {:phoenix_ecto, "~> 1.1"},
      {:postgrex, ">= 0.0.0"},
      {:poison, "~> 2.0", override: true},
      {:cowboy, "~> 1.0"},
      {:airbrakex, "~> 0.0.4"}
    ]
  end
end
