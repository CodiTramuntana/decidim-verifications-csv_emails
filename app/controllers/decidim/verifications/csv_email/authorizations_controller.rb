# frozen_string_literal: true

module Decidim
  module Verifications
    module CsvEmail
      class AuthorizationsController < Decidim::ApplicationController
        helper_method :authorization

        before_action :load_authorization

        def new
          authorize! :create, @authorization
          @form = CsvEmailForm.new
        end

        def create
          authorize! :create, @authorization

          @form = CsvEmailForm.from_params(params.merge(user: current_user))
          ConfirmCsvEmailUserAuthorization.call(@authorization, @form) do
            on(:ok) do
              flash[:notice] = t("authorizations.create.success", scope: "decidim.verifications.csv_email")
              redirect_to decidim_verifications.authorizations_path
            end
            on(:invalid) do
              flash.now[:alert] = t("authorizations.create.error", scope: "decidim.verifications.csv_email")
              render :new
            end
          end
        end

        private

        def authorization
          @authorization_presenter ||= AuthorizationPresenter.new(@authorization)
        end

        def load_authorization
          @authorization = Decidim::Authorization.find_or_initialize_by(
            user: current_user,
            name: "csv_email_authorization_handler"
          )
        end
      end
    end
  end
end
