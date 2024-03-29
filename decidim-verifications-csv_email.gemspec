# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

require "decidim/verifications/csv_email/version"

Gem::Specification.new do |s|
  s.version = Decidim::Verifications::CsvEmail.version
  s.authors = ["Isaac Massot"]
  s.email = ["isaac.mg@coditramuntana.com"]
  s.license = "AGPL-3.0"
  s.homepage = "https://github.com/decidim/decidim"
  s.required_ruby_version = ">= 2.7.5"

  s.name = "decidim-verifications-csv_email"
  s.summary = "Integration with CSV email verifications"
  s.description = s.summary

  s.files = Dir["{app,config,lib}/**/*", "LICENSE-AGPLv3.txt", "Rakefile", "README.md"]

  s.add_dependency "decidim", ">=#{Decidim::Verifications::CsvEmail.decidim_version}"
  s.add_dependency "decidim-admin", ">=#{Decidim::Verifications::CsvEmail.decidim_version}"
  s.add_dependency "decidim-verifications", ">=#{Decidim::Verifications::CsvEmail.decidim_version}"

  # Security fixes
  # nokogiri: GHSA-2rr5-8q37-2w7h
  s.add_dependency "nokogiri", ">=1.12.5"
  # puma: GHSA-48w2-rm65-62xx
  s.add_dependency "puma", ">= 5.5.1"

  s.add_development_dependency "decidim-dev", ">=#{Decidim::Verifications::CsvEmail.decidim_version}"
end
