# frozen_string_literal: true

module Decidim
  module Verifications
    module CsvEmail
      module Admin
        # Defines the abilities related to csv_email for a logged in admin user.
        class Permissions < Decidim::DefaultPermissions
          def permissions
            return permission_action if permission_action.scope != :admin
            if user.organization.available_authorizations.include?("csv_email_authorization_handler")
              allow! if permission_action.subject == Decidim::Verifications::CsvEmail::CsvEmailDatum
              permission_action
            end
          end
        end
      end
    end
  end
end
