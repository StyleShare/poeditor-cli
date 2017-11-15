require_relative "lib/poeditor/version"
require "date"

Gem::Specification.new do |s|
  s.name        = "poeditor-cli"
  s.version     = POEditor::VERSION
  s.date        = Date.today
  s.summary     = "POEditor CLI"
  s.description = "POEditor CLI"
  s.authors     = ["Suyeol Jeon"]
  s.email       = "devxoul@gmail.com"
  s.files       = ["lib/poeditor.rb"]
  s.homepage    = "https://github.com/devxoul/poeditor-cli"
  s.license     = "MIT"

  s.files = Dir["lib/**/*.rb"] + %w{ bin/poeditor README.md LICENSE }

  s.executables   = %w{ poeditor }
  s.require_paths = %w{ lib }

  s.add_runtime_dependency "colorize", "~> 0.8"

  s.required_ruby_version = ">= 2.1"
end
