class ChangeContactEmailsToJsonb < ActiveRecord::Migration[7.2]
  def change
    change_column :users, :contact_emails, :jsonb, using: 'contact_emails::jsonb'
  end
end
