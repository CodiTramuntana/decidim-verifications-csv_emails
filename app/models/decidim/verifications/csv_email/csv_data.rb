# frozen_string_literal: true

require "csv"

module Decidim
  module Verifications
    module CsvEmail
      class CsvData
        attr_reader :errors, :values

        def initialize(file)
          @file = file
          @errors = []
          @values = []

          CSV.foreach(@file, headers: true, col_sep: ";") do |row|
            process_row(row)
          end
        end

        private

        def process_row(row)
          user_email = row[0]
          if user_email.present?
            values << row
          else
            errors << row
          end
        end
      end
    end
  end
end
