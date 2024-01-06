# WallabyFillForm

`WallabyFillForm` allows you to specify a keyword list of attributes to be input
rather than procedurally calling Wallaby's DSL methods.

## Usage

```elixir
session
|> visit("/sign_up")
|> WallabyFillForm.fill_form(%{
  :email => "email@example.com",
  :password => "password",
  "First Name" => "Name",
  :subscribe => true,
})

# It also works with keyword lists

session
|> visit("/sign_up")
|> WallabyFillForm.fill_form([email: "email@example.com"])
```

## Installation

Add `wallaby_fill_form` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:wallaby_fill_form, "~> 0.1.0"},
  ]
end
```

## Supported Types

| Type of Value                  | Action                                 |
|--------------------------------|----------------------------------------|
| `is_boolean/1`                 | Sets a checkbox                        |
| `is_binary/1` or `is_number/1` | `fill_in/3` or selects from a dropdown |

## Contributing

See the [CONTRIBUTING] document.
Thank you, [contributors]!

  [CONTRIBUTING]: CONTRIBUTING.md
  [contributors]: https://github.com/thoughtbot/wallaby_fill_form/graphs/contributors

## License

WallabyFillForm is Copyright (c) 2017 thoughtbot, inc.
It is free software, and may be redistributed
under the terms specified in the [LICENSE] file.

  [LICENSE]: /LICENSE

## About

![thoughtbot][thoughtbot-logo]

WallabyFillForm is maintained and funded by [thoughtbot], inc.
The names and logos for thoughtbot are trademarks of thoughtbot, inc.

We love open source software, Elixir, and Phoenix. See [our other Elixir
projects][elixir-phoenix], or [hire our Elixir/Phoenix development team][hire]
to design, develop, and grow your product.

  [thoughtbot]: https://thoughtbot.com?utm_source=github
  [thoughtbot-logo]: http://presskit.thoughtbot.com/images/thoughtbot-logo-for-readmes.svg
  [elixir-phoenix]: https://thoughtbot.com/services/elixir-phoenix?utm_source=github
  [hire]: https://thoughtbot.com?utm_source=github
