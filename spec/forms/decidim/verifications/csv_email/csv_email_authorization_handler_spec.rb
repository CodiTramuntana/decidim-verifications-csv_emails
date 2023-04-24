# frozen_string_literal: true

require "spec_helper"

describe CsvEmailAuthorizationHandler do
  subject(:form) { described_class.from_params(attributes) }

  let!(:user) { create(:user) }
  let(:random_email) { "#{Time.current.to_i}@example.org" }
  let(:attributes) do
    {
      email: user.email,
      user: user
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
          Decidim::Verifications::CsvEmail::CsvEmailDatum.create!(organization: user.organization, email: user.email)
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

  context "when unique_id is generated correctly" do
    let(:handler_name) { "csv_email_authorization_handler" }
    let(:unique_id) do
      Digest::SHA256.hexdigest(
        "#{user&.decidim_organization_id}-#{user.email}-#{handler_name}-#{Rails.application.secrets.secret_key_base}"
      )
    end

    it { expect(unique_id).to eq(form.unique_id) }
  end
end
