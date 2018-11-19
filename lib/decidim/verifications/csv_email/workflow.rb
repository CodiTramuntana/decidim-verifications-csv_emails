# frozen_string_literal: true
require 'decidim/verifications'

Decidim::Verifications.register_workflow(:csv_email_authorization_handler) do |workflow|
  workflow.engine = Decidim::Verifications::CsvEmail::Engine
  workflow.admin_engine = Decidim::Verifications::CsvEmail::AdminEngine
end
