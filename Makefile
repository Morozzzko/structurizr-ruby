.PHONY: download-jars test


download-jars:
	rm -f structurizr-jars/*.jar
	mvn dependency:get -Dartifact=com.structurizr:structurizr-core:LATEST -Ddest=./structurizr-jars
	mvn dependency:get -Dartifact=com.structurizr:structurizr-graphviz:LATEST -Ddest=./structurizr-jars
	mvn dependency:get -Dartifact=com.structurizr:structurizr-client:LATEST -Ddest=./structurizr-jars

test:
	jruby -S bundle exec rake test

setup:
	jruby -S gem install bundler
	jruby -S bundle install

