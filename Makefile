.PHONY: test transpile install setup bundle lint console download-jars build-gem build

test:
	jruby -Itest -Ilib bin/test

transpile:
	ruby-next nextify ./lib

install:
	jruby -S gem install bundler
	jruby -S bundle install

setup: install transpile

bundle:
	jruby -S bundle

lint:
	jruby -S bundle exec rubocop

console:
	bin/console

download-jars:
	 jruby -rjars/installer -e 'Jars::Installer.vendor_jars!'

build-gem:
	gem build

build: transpile build-gem
