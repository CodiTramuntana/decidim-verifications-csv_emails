# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

# Force gem rails to 5.2.2.1 to fix some vulnerabilities
# on actionview and railties
# It can be removed when new stable version will be released or
# when Decidim force the rails version
gem 'rails', '5.2.2.1'

gemspec

group :development, :test do
  gem "faker", "~> 1"
  gem "byebug", "~> 10.0", platform: :mri
  gem 'bootsnap'
  gem 'listen'
  gem 'social-share-button'
end

group :development do
  gem "web-console", "~> 3.5"
end
