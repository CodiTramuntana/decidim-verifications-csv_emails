# frozen_string_literal: true

module Decidim
  module Verifications
    module CsvEmail
      # Provides information about the current status of the emails data
      # for a given organization
      class Status
        def initialize(organization)
          @organization = organization
        end

        # Returns the date of the last import
        def last_import_at
          @last ||= CsvEmailDatum.inside(@organization)
                                 .order(created_at: :desc).first
          @last ? @last.created_at : nil
        end

        # Returns the number of unique emails
        def count
          @count ||= CsvEmailDatum.inside(@organization)
                                  .distinct.count(:email)
          @count
        end
      end
    end
  end
end
