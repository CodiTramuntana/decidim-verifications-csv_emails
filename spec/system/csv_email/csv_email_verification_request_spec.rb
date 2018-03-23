# frozen_string_literal: true

require "spec_helper"

describe "Genesys I3 verification request", type: :system do
  # let!(:organization) do
  #   create(:organization, available_authorizations: ["genesys_i3"])
  # end
  # let!(:user) { create(:user, :confirmed, organization: organization) }
  # let!(:valid_genesys_i3) do
  #   {
  #     document_number: "X0000000F",
  #     birthdate: Date.new(1973, 1, 18)
  #   }
  # end
  # let!(:invalid_genesys_i3) do
  #   {
  #     document_number: "XXXXXXXXX",
  #     birthdate: ""
  #   }
  # end
  #
  # before do
  #   switch_to_host(organization.host)
  #   login_as user, scope: :user
  #   visit decidim_genesys_i3.root_path
  # end
  #
  # it "redirects to verification after login" do
  #   expect(page).to have_content("Verify with Genesys I3")
  # end
  #
  # it "allows the user to fill up form field", genesys_i3_stub_type: :valid do
  #   submit_genesys_i3_form(
  #     document_number: valid_genesys_i3[:document_number],
  #     birthdate: valid_genesys_i3[:birthdate]
  #   )
  #
  #   expect(page).to have_current_path decidim_verifications.authorizations_path
  #   expect(page).to have_content("Genesys I3 verification requested successfully")
  # end
  #
  # it "shows an error when data is not valid" do
  #   submit_genesys_i3_form(
  #     document_number: invalid_genesys_i3[:document_number],
  #     birthdate: valid_genesys_i3[:birthdate]
  #   )
  #
  #   expect(page).to have_content("Not valid DNI/NIE. Must be all uppercase, contain only letters and/or numbers, and start with a number or letters X, Y or Z.")
  # end
  #
  # it "shows an error when data is not valid in Genesy I3", genesys_i3_stub_type: :invalid do
  #   submit_genesys_i3_form(
  #     document_number: valid_genesys_i3[:document_number],
  #     birthdate: valid_genesys_i3[:birthdate]
  #   )
  #
  #   expect(page).to have_content("Your data do not correspond to the census")
  # end
  #
  # it "does not submit when data is not fulfilled" do
  #   submit_genesys_i3_form(
  #     document_number: invalid_genesys_i3[:document_number],
  #     birthdate: invalid_genesys_i3[:birthdate]
  #   )
  #
  #   expect(page).to have_current_path decidim_genesys_i3.root_path
  # end
  #
  # private
  #
  # def submit_genesys_i3_form(document_number:, birthdate:)
  #   fill_in "Document number", with: document_number
  #   if birthdate.presence
  #     page.execute_script(%{$("#date_field_genesys_i3_birthdate").fdatepicker("update", "#{birthdate.strftime('%d/%m/%Y')}")})
  #     page.execute_script(%{$("#date_field_genesys_i3_birthdate").trigger({type: "changeDate", date: "#{birthdate.strftime('%Y/%m/%d')}"})})
  #   end
  #
  #   click_button "Request verification"
  # end
end
