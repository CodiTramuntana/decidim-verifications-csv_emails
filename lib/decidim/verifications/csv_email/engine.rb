# frozen_string_literal: true

require "rails"
require "decidim/core"

module Decidim
  module Verifications
    module CsvEmail
      class Engine < ::Rails::Engine
        isolate_namespace Decidim::Verifications::CsvEmail

        routes do
          resource :authorizations, only: %i[new create], as: :authorization

          root to: "authorizations#new"
        end

        initializer "decidim_csv_email.add_authorization_handlers" do |_app|
          Decidim::Verifications.register_workflow(:csv_email_authorization_handler) do |workflow|
            workflow.form = "CsvEmailAuthorizationHandler"
            # workflow.engine = Decidim::Verifications::CsvEmail::Engine
            # workflow.admin_engine = Decidim::Verifications::CsvEmail::AdminEngine
          end
        end

        config.to_prepare do
          Dir.glob("#{Decidim::Verifications::CsvEmail::Engine.root}/app/decorators/**/*_decorator*.rb").each do |c|
            require_dependency(c)
          end
        end
      end
    end
  end
end
