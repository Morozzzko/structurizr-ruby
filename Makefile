.PHONY: download-jars test


download-jars:
	rm -f structurizr-jars/*.jar
	mvn dependency:get -Dartifact=commons-logging:commons-logging:LATEST -Ddest=./lib/structurizr/jars/
	mvn dependency:get -Dartifact=com.structurizr:structurizr-core:LATEST -Ddest=./lib/structurizr/jars/
	mvn dependency:get -Dartifact=com.structurizr:structurizr-graphviz:LATEST -Ddest=./lib/structurizr/jars/
	mvn dependency:get -Dartifact=com.structurizr:structurizr-client:LATEST -Ddest=./lib/structurizr/jars/

test:
	jruby -S bundle exec rake test

setup:
	jruby -S gem install bundler
	jruby -S bundle install

bundle:
	jruby -S bundle

lint:
	jruby -S bundle exec rubocop
