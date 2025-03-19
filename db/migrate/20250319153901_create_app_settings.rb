class CreateAppSettings < ActiveRecord::Migration[7.2]
  def change
    create_table :app_settings do |t|
      t.integer :remind_after_quantity, null: false, default: 7
      t.string :remind_after_unit, null: false, default: "days"
      t.text :reminder_email_text, null: false, default: "Ovo je podsjetnik za vaš zadatak."

      t.timestamps
    end
  end
end