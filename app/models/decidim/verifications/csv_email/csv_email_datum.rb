# frozen_string_literal: true

module Decidim
  module Verifications
    module CsvEmail
      class CsvEmailDatum < ApplicationRecord
        belongs_to :organization, foreign_key: :decidim_organization_id,
                                  class_name: "Decidim::Organization",
                                  inverse_of: :csv_email_datum

        # An organzation scope
        def self.inside(organization)
          where(decidim_organization_id: organization.id)
        end

        # Search for a specific email inside an organization
        def self.search_user_email(organization, email)
          CsvEmailDatum.inside(organization)
                       .where(email: email)
                       .order(created_at: :desc, id: :desc)
                       .first
        end

        # Insert a collectiojn of values
        def self.insert_all(organization, values)
          table_name = CsvEmailDatum.table_name
          columns = %w[email decidim_organization_id created_at].join(",")
          now = Time.current
          values = values.map do |row|
            "('#{row[0]}', '#{organization.id}', '#{now}')"
          end
          sql = "INSERT INTO #{table_name} (#{columns}) VALUES #{values.join(',')}"
          ActiveRecord::Base.connection.execute(sql)
        end

        # Clear all census data for a given organization
        def self.clear(organization)
          CsvEmailDatum.inside(organization).delete_all
        end
      end
    end
  end
end
