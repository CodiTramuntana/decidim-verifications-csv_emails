# frozen_string_literal: true

module Decidim
  module Verifications
    module CsvEmail
      class AdminEngine < ::Rails::Engine
        isolate_namespace Decidim::Verifications::CsvEmail::Admin
        paths["db/migrate"] = nil

        routes do
          resources :csv_verifications, only: %i[index create] do
            collection do
              delete :destroy_all
            end
          end

          root to: "csv_verifications#index"
        end
      end
    end
  end
end
