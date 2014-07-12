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

end
