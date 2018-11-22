# frozen_string_literal: true

FactoryBot.define do
  factory :csv_email_datum, class: Decidim::Verifications::CsvEmail::CsvEmailDatum do
    email { "user@example.org" }
    organization
  end
end
