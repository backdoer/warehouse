defmodule Warehouse.MixProject do
  use Mix.Project

  def project do
    [
      app: :warehouse,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Warehouse.Application, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 0.8.10", only: [:dev, :test]},
      {:erlport, "~> 0.9"}
    ]
  end
end
