defmodule SassTest do
  use ExUnit.Case

  test "Sass.compile/1 compiles a SASS string to CSS" do
    { :ok, sass_string } = File.read("test/sample_sass.sass")
    { :ok, css_string }  = File.read("test/sample_sass.css")
    expected_css         = String.strip(css_string)
    { :ok, result_css }  = Sass.compile(sass_string)

    assert expected_css == result_css
  end

  test "Sass.compile/1 compiles a SCSS string to CSS" do
    { :ok, scss_string } = File.read("test/sample_scss.scss")
    { :ok, css_string }  = File.read("test/sample_scss.css")
    expected_css         = String.strip(css_string)
    { :ok, result_css }  = Sass.compile(scss_string)

    assert expected_css == result_css
  end

end
