# frozen_string_literal: true

Decidim::Verifications::Adapter.class_eval do
  #
  # Administrational entry point for the verification engine
  #
  def admin_root_path
    admin_engine.send(:root_path, redirect_params)
  end
end
