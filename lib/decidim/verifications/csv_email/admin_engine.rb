# frozen_string_literal: true

module Decidim
  module Verifications
    module CsvEmail
      class AdminEngine < ::Rails::Engine

        isolate_namespace Decidim::Verifications::CsvEmail::Admin

        routes do
          resources :csv_verifications, only: %i(index create) do
            collection do
              delete :destroy_all
            end
          end
        
          root to: "csv_verifications#index"
        end

        initializer 'decidim_verifications_csv_emails.add_admin_authorizations' do |_app|
          Decidim.configure do |config|
            config.admin_abilities += [
              'Decidim::Verifications::CsvEmail::Abilities::AdminAbility'
            ]
          end
        end

      end
    end
  end
end
