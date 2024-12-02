class ContactEmail < ApplicationRecord
  belongs_to :user

  # Optional: Add validations for the email format
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
