# frozen_string_literal: true

module Decidim
  module Verifications
    module CsvEmail
      class RemoveDuplicatesJob < ApplicationJob
        queue_as :default

        def perform(organization)
          duplicated_census(organization).pluck(:email).each do |email|
            CsvEmailDatum.inside(organization)
                         .where(email: email)
                         .order(id: :desc)
                         .all[1..-1]
                         .each(&:delete)
          end
        end

        private

        def duplicated_census(organization)
          CsvEmailDatum.inside(organization)
                       .select(:email)
                       .group(:email)
                       .having("count(email)>1")
        end
      end
    end
  end
end
