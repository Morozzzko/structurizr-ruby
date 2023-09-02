# Structurizr

[![Test Coverage](https://api.codeclimate.com/v1/badges/b75e8c130fc8b3bf54b5/test_coverage)](https://codeclimate.com/github/Morozzzko/structurizr-ruby/test_coverage)[![Maintainability](https://api.codeclimate.com/v1/badges/b75e8c130fc8b3bf54b5/maintainability)](https://codeclimate.com/github/Morozzzko/structurizr-ruby/maintainability)


`structurizr-ruby` brings the [C4 model](https://c4model.com) to Ruby. It piggybacks on top of [Java's API](https://github.com/structurizr/java) for [Structurizr](https://structurizr.com), which is a powerful tool for incorporating C4 model into your software architecture process.

The primary goal is to enable better introspection & scripting for workspaces defined by Structurizr DSL.

Number 1 feature of this library is actually a runnable `REPL` which allows a flexible introspection. You can run it via `structurizr-repl <workspace.json>`.

As a bonus, this library provides a complete integration to build Structurizr workspace from Ruby. However, it doesn't make much sense since there's [Structurizr DSL](https://structurizr.com/help/dsl). However, it's still a bit useful if you're using [DSL's scripting feature](https://github.com/structurizr/dsl/blob/master/docs/language-reference.md#scripts), you might find this library a bit useful.

If you've met something which doesn't have a nice Ruby DSL, you can always use [`Structurizr::Metal`](/lib/structurizr/metal.rb) to access Java classes and methods. Please don't forget to [submit issue or a pull-request](#Contributing) which describes your use-case and the missing features.

## Versioning

After entering 1.0, this library will follow Structurizr-core versioning. If the gem bundles `structurizr-core` 1.26.1, the gem will use version 1.26.1. 

Since Structurizr **does not follow SemVer**, there are no guarantees that minor versions won't break anything. 

At least we have version parity with Structurizr.

## Installation

Install the gem:

    $ jruby -S gem install structurizr

or add it to your Gemfile via CLI:

    $ jruby -S bundle add structurizr

or just edit your `Gemfile` manually:

```ruby
# Gemfile

gem 'structurizr'
```

## Usage

Before you start, you need to `require` the necessary files:

```ruby
require 'structurizr'
```

If you have a `workspace.json`, you can run an interactive REPL to read values from it: `structurizr-repl workspace.json`

## Development

After checking out the repo, run `make setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `jruby -S bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Morozzzko/structurizr. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/Morozzzko/structurizr-ruby/blob/master/CODE_OF_CONDUCT.md).


## Code of Conduct

Everyone interacting in the Structurizr project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/Morozzzko/structurizr-ruby/blob/master/CODE_OF_CONDUCT.md).
