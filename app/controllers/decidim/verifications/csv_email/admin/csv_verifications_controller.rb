# frozen_string_literal: true

module Decidim
  module Verifications
    module CsvEmail
      module Admin
        class CsvVerificationsController < Decidim::Admin::ApplicationController
          layout "decidim/admin/users"

          before_action :show_instructions,
                        unless: :csv_emails_authorization_active_in_organization?

          def index
            authorize! :index, CsvEmailDatum
            @status = Status.new(current_organization)
          end

          def create
            authorize! :create, CsvEmailDatum
            if params[:file]
              data = CsvData.new(params[:file].path)
              CsvEmailDatum.insert_all(current_organization, data.values)
              RemoveDuplicatesJob.perform_later(current_organization)
              flash[:notice] = t(".success", count: data.values.count,
                                             errors: data.errors.count)
            end
            redirect_to csv_verifications_path
          end

          def destroy_all
            authorize! :destroy, CsvEmailDatum
            CsvEmailDatum.clear(current_organization)

            redirect_to csv_verifications_path, notice: t(".success")
          end

          private

          def show_instructions
            render :instructions
          end

          def csv_emails_authorization_active_in_organization?
            current_organization.available_authorizations.include?("csv_email_authorization_handler")
          end
        end
      end
    end
  end
end
