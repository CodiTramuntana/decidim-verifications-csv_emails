# frozen_string_literal: true

module Decidim
  module Verifications
    module CsvEmail
      class ApplicationController < ActionController::Base
        protect_from_forgery with: :exception
      end
    end
  end
end
