# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

# Specify your gem's dependencies in kaminari.gemspec
gemspec

gem "decidim", path: "../"

group :development, :test do
  gem "byebug", "~> 10.0", platform: :mri
end

group :development do
  gem "faker", "~> 1.8"
  gem "web-console", "~> 3.5"
end
