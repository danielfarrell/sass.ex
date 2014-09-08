Code.require_file "lib/mix/tasks/compile.sass.ex"

defmodule Sass.Mixfile do
  use Mix.Project

  def project do
    [
      app:         :sass,
      version:     "0.0.1",
      elixir:      "~> 1.0.0",
      compilers:   [:sass, :elixir, :app],
      deps:        deps(Mix.env),
      package:     package,
      description: description
    ]
  end

  def application, do: []

  defp description do
    """
    Elixir NIF for libsass, a Sass parser
    """
  end

  defp package do
    [
      contributors: ["Daniel Farrell"],
      license:      "MIT",
      links: [
        { "GitHub", "https://github.com/danielfarrell/sass.ex" },
        { "Issues", "https://github.com/sanielfarrell/sass.ex/issues" },
        { "Source (sass/libsass)", "https://github.com/sass/libsass" }
      ],
      files: [
        "lib",
        "src",
        "libsass_src",
        "priv",
        "Makefile",
        "mix.exs",
        "README.md",
        "LICENSE"
      ]
    ]
  end

  defp deps(:docs) do
    [{ :ex_doc, github: "elixir-lang/ex_doc" }]
  end

  defp deps(_) do
    []
  end
end
