# frozen_string_literal: true

Decidim::User.class_eval do
  protected

  def after_confirmation
    @census_for_user ||= Decidim::Verifications::CsvEmail::CsvEmailDatum
                         .search_user_email(organization, email)

    return if @census_for_user.blank?
    @authorization = Decidim::Authorization.create(user: self, name: "csv_email_authorization_handler")
    @authorization.grant!
  end
end
