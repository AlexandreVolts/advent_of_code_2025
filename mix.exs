defmodule AdventOfCode2025.MixProject do
  use Mix.Project

  def project do
    [
      app: :advent_of_code_2025,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {AdventOfCode2025, ["--exercises", "0"]},
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [

    ]
  end
end
