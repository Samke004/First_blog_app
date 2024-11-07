class AddDetailsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :contact_emails, :json
    add_column :users, :blocked, :boolean
  end
end
