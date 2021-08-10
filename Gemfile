# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

gemspec

group :development, :test do
  gem "decidim"
  gem "faker", ">= 1"
  gem "byebug", ">= 10.0", platform: :mri
  gem 'bootsnap'
  gem 'listen'
  gem 'social-share-button'
end

group :development do
  gem "letter_opener_web", "~> 1.3"
  gem "web-console", "~> 3.5"
end
