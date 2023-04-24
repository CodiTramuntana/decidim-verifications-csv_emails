# Decidim Verifications CsvEmail

Allows to upload a CSV file to perform verifications against
real users parameterised.

## Usage

This module provides a model `Decidim::Verifications::CsvEmail` to store users informations (email).

It has an admin controller to upload CSV files with emails. When importing files all records are inserted and the duplicates are removed in a background job for performance reasons.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'decidim-verifications-csv_email', git: 'https://github.com/CodiTramuntana/decidim-verifications-csv_emails.git'
```

And then execute:

```bash
bundle
bin/rails decidim_verifications_csv_email:install:migrations
bin/rails db:migrate
```

Enable the CsvEmail verifier in the desired organization's `system/` panel.

## Run tests

Create a dummy app in your application (if not present):

```bash
bin/rails decidim:generate_external_test_app
# Copy migration into spec/decidim_dummy_app/db/migrate
cd spec/decidim_dummy_app/
bundle exec rails decidim_verifications_csv_email:install:migrations
RAILS_ENV=test bundle exec rails db:migrate
cd ../..
```

And run tests:

```bash
bundle exec rspec spec
```

## License

AGPLv3 (same as Decidim)
