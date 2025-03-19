class AppSetting < ApplicationRecord
    validates :remind_after_quantity, presence: true, numericality: { greater_than: 0 }
    validates :remind_after_unit, presence: true, inclusion: { in: %w[days months] }
    validates :reminder_email_text, presence: true
  
    def self.instance
      first_or_create(
        remind_after_quantity: 7,
        remind_after_unit: 'days',
        reminder_email_text: 'Ovo je podsjetnik za vaš zadatak.'
      )
    end
  end
  