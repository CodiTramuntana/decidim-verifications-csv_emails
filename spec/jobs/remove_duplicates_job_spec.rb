require 'spec_helper'

RSpec.describe Decidim::Verifications::CsvEmail::RemoveDuplicatesJob do
  let(:org1) { FactoryBot.create :organization }
  let(:org2) { FactoryBot.create :organization }

  it 'remove duplicates in the database' do
    %w[AAA BBB AAA AAA].each do |doc|
      FactoryBot.create(:csv_emai_datum, email: doc, organization: org1)
    end
    %w[AAA BBB AAA AAA].each do |doc|
      FactoryBot.create(:csv_emai_datum, email: doc, organization: org2)
    end

    expect(Decidim::Verifications::CsvEmail::CsvEmailDatum.count).to eq 8
    Decidim::Verifications::CsvEmail::RemoveDuplicatesJob.new.perform org1
    expect(Decidim::Verifications::CsvEmail::CsvEmailDatum.count).to eq 6
    Decidim::Verifications::CsvEmail::RemoveDuplicatesJob.new.perform org2
    expect(Decidim::Verifications::CsvEmail::CsvEmailDatum.count).to eq 4
  end
end
