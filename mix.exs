defmodule PlanningPoker.Mixfile do
  use Mix.Project

  def project do
    [
      app: :planning_poker,
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
      mod: {PlanningPoker, []},
      applications: applications(Mix.env)
    ]
  end

  defp applications do
     ~w(
       phoenix phoenix_html cowboy logger
       phoenix_ecto postgrex poison rollbax
       )a
  end

  defp applications :test do
    applications ++ ~w(tuco_tuco)a
  end

  defp applications _ do
    applications
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
      {:phoenix_html, "~> 2.1"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:poison, "~> 1.4.0"},
      {:cowboy, "~> 1.0"},
      {:plug_cors, "~> 0.7.3"},
      {:inflex, "~> 1.4.1"},
      {:rollbax, "~> 0.0.1"},
      {:tuco_tuco, "~> 0.7.1"},
      {:webdriver, github: "fazibear/elixir-webdriver", branch: "update-dependencies", override: true}
    ]
  end
end
