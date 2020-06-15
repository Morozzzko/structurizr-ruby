# Structurizr

[![Test Coverage](https://api.codeclimate.com/v1/badges/b75e8c130fc8b3bf54b5/test_coverage)](https://codeclimate.com/github/Morozzzko/structurizr-ruby/test_coverage)[![Maintainability](https://api.codeclimate.com/v1/badges/b75e8c130fc8b3bf54b5/maintainability)](https://codeclimate.com/github/Morozzzko/structurizr-ruby/maintainability)


`structurizr-ruby` brings the [C4 model](https://c4model.com) to Ruby. It piggybacks on top of [Java's API](https://github.com/structurizr/java) for [Structurizr](https://structurizr.com), which is (so far) the most powerful tool for incorporating C4 model into your software architecture process. It also serves as an architecture hub, so the ultimate goal of this gem is to _bootstrap_ your C4 model and help you _maintain_ it using plain Ruby code.

Here are the things you should be able to do with this gem as we progress:

* Create a C4 model of your architecture using Ruby
* Publish it to your Structurizr workspace
* Test your diagrams
* Create plain and simple diagrams
* Customize its rendering
* Manage [architecture decision records](https://github.com/joelparkerhenderson/architecture_decision_record)
* Manage documentation

While I'm aiming for a good feature compatibility with Java's structurizr, I simply can't add every available feature right away. Any help is welcome, so if your feature is missing, please report it or send a pull-request – both will be extremely helpful

## Installation

Install the gem:

    $ gem install structurizr

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Morozzzko/structurizr. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/Morozzzko/structurizr-ruby/blob/master/CODE_OF_CONDUCT.md).


## Code of Conduct

Everyone interacting in the Structurizr project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/Morozzzko/structurizr-ruby/blob/master/CODE_OF_CONDUCT.md).
