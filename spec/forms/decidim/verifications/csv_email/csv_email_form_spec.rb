# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Verifications
    module CsvEmail
      describe CsvEmailForm do
        subject(:form) { described_class.from_params(attributes) }

        let(:user) { create(:user) }
        let(:random_email) { "#{Time.current.to_i}@example.org" }
        let(:attributes) do
          {
            email: email,
            user: user,
          }
        end

        context "when is a valid email" do
          context "when the email is not the same than current user email" do
            let(:email) { random_email }
            it { is_expected.not_to be_valid }
          end

          context "when the email is the same than user" do
            let(:email) { user.email }
            context "when email exists in csv" do
              before do
                CsvEmailDatum.create!(organization: user.organization, email: user.email)
              end
              it { is_expected.to be_valid }
            end
            context "when email not exists in csv" do
              it { is_expected.not_to be_valid }
            end
          end
        end

        context "when is an invalid email" do
          let(:email) { "aaa.cccc" }

          it { is_expected.not_to be_valid }
        end
      end
    end
  end
end
