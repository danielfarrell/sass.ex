defmodule SassTest do
  use ExUnit.Case

  test "Sass.compile/1 compiles a SCSS string to CSS" do
    scss_string = "#navbar {width: 80%;height: 23px;ul { list-style-type: none; } li {float: left; a { font-weight: bold; } } }"
    { :ok, expected_css }  = File.read("test/sample_scss.css")
    { :ok, result_css }  = Sass.compile(scss_string)

    assert expected_css == result_css
  end

  test "Sass.compile/1 compiles a SASS file to CSS" do
    { :ok, sass_string } = File.read("test/sample_sass.sass")
    { :ok, expected_css }  = File.read("test/sample_sass.css")
    { :ok, result_css }  = Sass.compile(sass_string)

    assert expected_css == result_css
  end

  test "Sass.compile/1 compiles a SCSS file to CSS" do
    { :ok, scss_string } = File.read("test/sample_scss.scss")
    { :ok, expected_css }  = File.read("test/sample_scss.css")
    { :ok, result_css }  = Sass.compile(scss_string)

    assert expected_css == result_css
  end

end
