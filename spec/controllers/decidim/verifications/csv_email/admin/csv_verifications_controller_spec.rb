# frozen_string_literal: true

require "spec_helper"
RSpec.describe Decidim::Verifications::CsvEmail::Admin::CsvVerificationsController, type: :controller do
  routes { Decidim::Verifications::CsvEmail::AdminEngine.routes }

  let(:organization) do
    FactoryBot.create :organization, available_authorizations: ["csv_email_authorization_handler"]
  end

  let(:user) do
    FactoryBot.create :user, :confirmed, organization: organization, admin: true
  end

  before do
    controller.request.env["decidim.current_organization"] = organization
  end

  describe "GET #index" do
    it "returns http success" do
      sign_in user
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "when importing the csv data" do
      before do
        sign_in user

        # Don't know why don't prepend with `spec/fixtures` automatically
        file = fixture_file_upload("spec/fixtures/files/data1.csv")
        post :create, params: { file: file }
      end

      it "expects redirect" do
        expect(response).to have_http_status(:redirect)
      end

      it "expect data count" do
        expect(Decidim::Verifications::CsvEmail::CsvEmailDatum.count).to be 3
      end

      it "expect email user" do
        expect(Decidim::Verifications::CsvEmail::CsvEmailDatum.first.email).to eq "user@example.org"
      end

      it "expect email user2" do
        expect(Decidim::Verifications::CsvEmail::CsvEmailDatum.last.email).to eq "user3@example.org"
      end
    end
  end

  describe "POST #destroy_all" do
    context "when clearing all census data" do
      before do
        sign_in user

        5.times { FactoryBot.create :csv_email_datum, organization: organization }
        delete :destroy_all
      end

      it "expects redirect" do
        expect(response).to have_http_status(:redirect)
      end

      it "expect data count 0" do
        expect(Decidim::Verifications::CsvEmail::CsvEmailDatum.count).to be 0
      end
    end
  end
end
