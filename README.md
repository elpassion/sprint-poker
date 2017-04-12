# Sprint Poker [![Build Status](https://travis-ci.org/elpassion/sprint-poker.svg)](https://travis-ci.org/elpassion/sprint-poker)[![Code Climate](https://codeclimate.com/repos/58edf0c722fccf0268001d37/badges/66da3ec72dad0cb41e7c/gpa.svg)](https://codeclimate.com/repos/58edf0c722fccf0268001d37/feed)

Online estimation tool for Agile teams, written using [Elixir Lang], [Phoenix Framework].

http://sprintpoker.io

## Setup

- Install dependencies with `mix deps.get`
- Create database with `mix ecto.create`
- Migrate database with `mix ecto.migrate`
- Seed the database with `mix run priv/repo/seeds.exs`
- Start application with `mix phoenix.server`
- Run tests with `mix test`
- Install one of [frontends](#frontends)

## Frontends
- [sprint-poker-inesita](https://github.com/elpassion/sprint-poker-inesita)
- [sprint-poker-react](https://github.com/elpassion/sprint-poker-react)

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
[fork-and-pull]: https://help.github.com/articles/using-pull-requests
[LICENSE]: LICENSE
