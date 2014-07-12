# Sass.ex
Elixir NIF for [libsass](https://github.com/sass/libsass).

## Use

```shell
mix compile
iex -S mix
```

```elixir
Sass.compile "#navbar {width: 80%;height: 23px;ul { list-style-type: none; } li {float: left; a { font-weight: bold; } } }"
#=> {:ok, "#navbar {\n  width: 80%;\n  height: 23px; }\n  #navbar ul {\n    list-style-type: none; }\n  #navbar li {\n    float: left; }\n    #navbar li a {\n      font-weight: bold; }\n"}

Sass.compile_file "./test/sample_sass.sass"
#=> {:ok, "/* example.scss */\n#navbar {\n  width: 80%;\n  height: 23px; }\n  #navbar ul {\n    list-style-type: none; }\n  #navbar li {\n    float: left; }\n    #navbar li a {\n      font-weight: bold; }\n"}
```

## Roadmap

Obviously this is really early release software. The plans are:

- More Tests
- Better Documentation
- Compile a folder(sass_folder_context)
- Make a [Rotor](https://github.com/HashNuke/rotor)

## License

[MIT/X11](./LICENSE)

Copyright (c) 2014 Daniel Farrell

## Credit

Much of the code and explanation of how this could work was taken from two projects, [Discount.ex](https://github.com/asaaki/discount.ex/) and [Sassy](https://github.com/rramsden/sassy). Thanks guys!
