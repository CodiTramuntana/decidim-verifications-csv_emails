# frozen_string_literal: true

module Decidim
  module Verifications
    module CsvEmail
      # A form object to be used when public users want to get verified by
      # CsvEmail verificator
      class CsvEmailForm < AuthorizationHandler
        # This is the input (from the user) to validate against
        attribute :email, String

        # This is the validation to perform
        # If passed, an authorization is created
        validates :email, presence: true
        validate :censed

        def unique_id
          Digest::SHA256.hexdigest(
            "#{user&.decidim_organization_id}-#{user.email}-#{handler_name}-#{Rails.application.secrets.secret_key_base}"
          )
        end

        # Checks if the email belongs to the census
        def censed
          return if (email == user.email) && (census_for_user&.email == email)

          if email != user.email
            errors.add(:email, I18n.t("decidim.verifications.csv_email.errors.messages.not_same_email"))
          else
            errors.add(:email, I18n.t("decidim.verifications.csv_email.errors.messages.not_in_csv"))
          end
        end

        def authorized?
          return true if census_for_user
        end

        def census_for_user
          @census_for_user ||= Decidim::Verifications::CsvEmail::CsvEmailDatum
                               .search_user_email(organization, email)
        end

        def organization
          current_organization || user&.organization
        end
      end
    end
  end
end
