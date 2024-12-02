class CreateContactEmails < ActiveRecord::Migration[7.2]
  def change
    create_table :contact_emails do |t|
      t.string :email
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
