# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Verifications
    module CsvEmail
      describe RemoveDuplicatesJob do
        let(:org1) { FactoryBot.create :organization }
        let(:org2) { FactoryBot.create :organization }

        context "when there are duplicates in the database" do
          before do
            %w[AAA BBB AAA AAA].each do |doc|
              FactoryBot.create(:csv_email_datum, email: doc, organization: org1)
            end
            %w[AAA BBB AAA AAA cc1@email.com AAA].each do |doc|
              FactoryBot.create(:csv_email_datum, email: doc, organization: org2)
            end
          end

          it "count all registers in database" do
            expect(Decidim::Verifications::CsvEmail::CsvEmailDatum.count).to eq 10
          end

          it "removes register for org1" do
            described_class.new.perform org1
            expect(Decidim::Verifications::CsvEmail::CsvEmailDatum.count).to eq 8
          end

          it "removes register for org2" do
            described_class.new.perform org2
            expect(Decidim::Verifications::CsvEmail::CsvEmailDatum.count).to eq 7
          end
        end
      end
    end
  end
end
