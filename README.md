# Sprint Poker [![Build Status](https://magnum.travis-ci.com/elpassion/sprint-poker.svg?token=2hV2k43pXSF8AQERy7Fx&branch=master)](https://magnum.travis-ci.com/elpassion/sprint-poker)

Online estimation tool for Agile teams, written using [Elixir Lang], [Phoenix Framework] and [React].

http://sprintpoker.io

## Setup

- Install dependencies with `mix deps.get`
- Install npm dependencies with `npm install`
- Create database with `mix ecto.create`
- Migrate database with `mix ecto.migrate`
- Seed the database with `mix run priv/repo/seeds.exs`
- Start application with `mix phoenix.server`
- Run tests with `mix test`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Contributing

We follow the "[fork-and-pull]" Git workflow.

1. Fork the repo on GitHub
2. Commit changes to a branch in your fork
3. Pull request "upstream" with your changes
4. Merge changes in to "upstream" repo

NOTE: Be sure to merge the latest from "upstream" before making a pull request!

## License

Sprint Poker is released under the MIT License. See the [LICENSE] file for further details.

[Elixir Lang]: http://elixir-lang.org
[Phoenix Framework]: http://www.phoenixframework.org
[React]: http://facebook.github.io/react
[fork-and-pull]: https://help.github.com/articles/using-pull-requests
[LICENSE]: LICENSE
