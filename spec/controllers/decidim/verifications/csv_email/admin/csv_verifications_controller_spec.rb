require 'spec_helper'

RSpec.describe Decidim::Verifications::CsvEmail::Admin::CsvVerificationsController, type: :controller do

  routes { Decidim::Verifications::CsvEmail::AdminEngine.routes }

  let(:organization) do
    FactoryBot.create :organization, available_authorizations: ['csv_email_authorization_handler']
  end

  let(:user) do
    FactoryBot.create :user, :confirmed, organization: organization, admin: true
  end

  before :each do
    controller.request.env['decidim.current_organization'] = organization
  end

  describe 'GET #index' do
    it 'returns http success' do
      sign_in user
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    it 'imports the csv data' do
      sign_in user

      # Don't know why don't prepend with `spec/fixtures` automatically
      file = fixture_file_upload('spec/fixtures/files/data1.csv')
      post :create, params: { file: file }
      expect(response).to have_http_status(:redirect)

      expect(Decidim::Verifications::CsvEmail::CsvEmailDatum.count).to be 3
      expect(Decidim::Verifications::CsvEmail::CsvEmailDatum.first.email).to eq 'user@example.org'
      expect(Decidim::Verifications::CsvEmail::CsvEmailDatum.last.email).to eq 'user3@example.org'
    end
  end

  describe 'POST #delete_all' do
    it 'clear all census data' do
      sign_in user

      5.times { FactoryBot.create :csv_email_datum, organization: organization }
      delete :destroy
      expect(response).to have_http_status(:redirect)

      expect(Decidim::Verifications::CsvEmail::CsvEmailDatum.count).to be 0
    end
  end
end
