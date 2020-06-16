.PHONY: download-jars


download-jars:
	rm -f structurizr-jars/*.jar
	mvn dependency:get -Dartifact=com.structurizr:structurizr-core:LATEST -Ddest=./structurizr-jars
	mvn dependency:get -Dartifact=com.structurizr:structurizr-graphviz:LATEST -Ddest=./structurizr-jars
	mvn dependency:get -Dartifact=com.structurizr:structurizr-client:LATEST -Ddest=./structurizr-jars
