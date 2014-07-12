defmodule Sass do

  def compile(string) do
    Sass.Compiler.compile(string)
  end

end
