# frozen_string_literal: true

module Decidim
  module Verifications
    module CsvEmail
      class ConfirmCsvEmailUserAuthorization < Decidim::Verifications::ConfirmUserAuthorization

        def call
          return broadcast(:invalid) unless form.valid?

          if confirmation_successful?
            authorization.grant!
            broadcast(:ok)
          else
            broadcast(:invalid)
          end
        end
      end
    end
  end
end
