defmodule Sass do
  @moduledoc """
    Compiles SASS into CSS
  """

  @doc """
    Compiles a string of SASS into a string of CSS
  """
  def compile(string) do
    Sass.Compiler.compile(string)
  end

  @doc """
    Compiles a file of SASS into a string of CSS
  """
  def compile_file(path) do
    Sass.Compiler.compile_file(path)
  end

end
