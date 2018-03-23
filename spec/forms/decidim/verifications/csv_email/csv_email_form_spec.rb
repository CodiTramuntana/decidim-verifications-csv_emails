# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Verifications
    module GenesysI3
      describe GenesysI3Form do
        subject do
          described_class.new(
            document_number: document_number,
            birthdate: birthdate
          )
        end

        let(:user) { create(:user) }

        let(:document_number) { "X0000000F" }
        let(:birthdate) { Date.new(1973, 1, 18) }

        context "when the data is valid with NIE" do
          it "is valid", genesys_i3_stub_type: :valid do
            expect(subject).to be_valid
          end
        end

        context "when the data is valid with DNI" do
          let(:document_number) { "00000000T" }

          it "is valid", genesys_i3_stub_type: :valid do
            expect(subject).to be_valid
          end
        end

        context "when the document number format is invalid" do
          let(:document_number) { "XXXXXXXX-Y" }

          it "is not valid" do
            expect(subject).not_to be_valid
            expect(subject.errors[:document_number])
              .to include("Not valid DNI/NIE. Must be all uppercase, contain only letters and/or numbers, and start with a number or letters X, Y or Z.")
          end
        end

        context "when the birthdate is blank" do
          let(:birthdate) { "" }

          it "is not valid" do
            expect(subject).not_to be_valid
            expect(subject.errors[:birthdate])
              .to include("can't be blank")
          end
        end
      end
    end
  end
end
