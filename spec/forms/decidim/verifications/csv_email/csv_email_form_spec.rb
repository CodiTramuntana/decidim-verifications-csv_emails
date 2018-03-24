# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Verifications
    module CsvEmail
      describe CsvEmailForm do
        subject(:form) { described_class.from_params(attributes).with_context(context) }

        # subject do
        #   described_class.new(
        #     email: email
        #   )
        # end

        let(:user) { create(:user) }

        let(:email) { "user@example.org" }

        let(:attributes) do
          {
            email: email

          }
        end

        context "when is a valid email" do
          context "when the email is not the same than current user email" do
            it { is_expected.not_to be_valid }
            #
            # it "is not valid" do
            #   expect(subject).not_to be_valid
            #   # expect(subject.errors[:email]).to include("Email entered is not the same as the user logged in")
            # end
          end

          context "when the email is the same than user" do
            context "when email exists in csv" do
              it { is_expected.to be_valid }
              # it "is valid" do
              #   expect(subject).to be_valid
              # end
            end
            context "when email not exists in csv" do
              it { is_expected.not_to be_valid }
              # it "is not valid" do
              #   expect(subject).not_to be_valid
              #   # expect(subject.errors[:email]).to include("We could not find your email in our database of members. If the email entered is correct and the problem persists, please, contact an administrator.")
              # end
            end
          end
        end

        context "when is an invalid email" do
          let(:email) { "aaa.cccc" }

          it { is_expected.not_to be_valid }

          # it "is not valid" do
          #   expect(subject).not_to be_valid
          #   # expect(subject.errors[:email]).to include("We could not find your email in our database of members. If the email entered is correct and the problem persists, please, contact an administrator.")
          # end
        end
      end
    end
  end
end
