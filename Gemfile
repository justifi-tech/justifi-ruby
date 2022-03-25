# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in justifi.gemspec
gemspec

gem "rake", "~> 13.0"

gem "rspec", "~> 3.0"

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "dotenv"
  gem "rubocop"
  gem "standard"
  gem "webmock", ">= 3.8.0"
  gem "simplecov-small-badge", require: false
end

gem "simplecov", require: false, group: :test
