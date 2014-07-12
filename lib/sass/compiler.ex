defmodule Sass.Compiler do
  @moduledoc """
    Connection to the NIF for libsass
  """

  @on_load { :init, 0 }

  @doc """
    Loads the sass.so library
  """
  def init do
    path = :filename.join(:code.priv_dir(:sass), 'sass')
    :ok = :erlang.load_nif(path, 0)
  end

  @doc """
    A noop that gets overwritten by the NIF compile
  """
  def compile(_) do
    exit(:nif_library_not_loaded)
  end

  @doc """
    A noop that gets overwritten by the NIF compile_file
  """
  def compile_file(_) do
    exit(:nif_library_not_loaded)
  end

end
