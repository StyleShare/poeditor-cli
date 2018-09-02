source "https://rubygems.org"

# runtime dependencies from gemspec
gemspec = File.read("poeditor-cli.gemspec")
gemspec.scan(/(?<=s\.add_runtime_dependency ).*/).each do |dependency|
  eval "gem #{dependency}"
end

group :development do
  gem 'minitest', '~> 5.9'
  gem 'webmock', '~> 2.3'
end

group :test do
  gem 'codecov', :require => false
end
