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
	rm -f lib/structurizr/metal/jars/*.jar
	mvn dependency:get -Dartifact=commons-logging:commons-logging:LATEST -Ddest=./lib/structurizr/metal/jars/
	mvn dependency:get -Dartifact=com.fasterxml.jackson.core:jackson-core:LATEST -Ddest=./lib/structurizr/metal/jars/
	mvn dependency:get -Dartifact=com.fasterxml.jackson.core:jackson-databind:LATEST -Ddest=./lib/structurizr/metal/jars/
	mvn dependency:get -Dartifact=com.fasterxml.jackson.core:jackson-annotations:LATEST -Ddest=./lib/structurizr/metal/jars/
	mvn dependency:get -Dartifact=com.structurizr:structurizr-core:LATEST -Ddest=./lib/structurizr/metal/jars/
	mvn dependency:get -Dartifact=com.structurizr:structurizr-graphviz:LATEST -Ddest=./lib/structurizr/metal/jars/
	mvn dependency:get -Dartifact=com.structurizr:structurizr-client:LATEST -Ddest=./lib/structurizr/metal/jars/

build-gem:
	gem build

build: transpile build-gem
