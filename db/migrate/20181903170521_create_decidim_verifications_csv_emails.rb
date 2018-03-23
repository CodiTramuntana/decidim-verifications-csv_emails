# frozen_string_literal: true
class CreateDecidimVerificationsCsvEmails < ActiveRecord::Migration[5.1]

  def change
    create_table :decidim_verifications_csv_email_csv_email_data do |t|
      t.references :decidim_organization, foreign_key: true, index: { name: "index_verifications_csv_email_to_organization" }
      t.string :email

      # The rows in this table are immutable (insert or delete, not update)
      # To explicitly reflect this fact there is no `updated_at` column
      t.datetime 'created_at', null: false
    end
  end

end
