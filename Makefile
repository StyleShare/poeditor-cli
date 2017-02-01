@all: clean build install

clean:
	rm -f poeditor-*.gem

build:
	gem build poeditor-cli.gemspec

install:
	gem install poeditor-*.gem

push: clean build
	gem push poeditor-*.gem
