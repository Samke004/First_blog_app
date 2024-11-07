class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_save :parse_contact_emails

  # Overriding Devise method to find user by either primary email or any contact email in JSON array
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    email = conditions.delete(:email)

    # Updated query using explicit JSON casting
    where(conditions).where(["email = :value OR contact_emails @> :json_value", { value: email, json_value: "[\"#{email}\"]" }]).first
  end

  private

  def parse_contact_emails
    if contact_emails.is_a?(String)
      self.contact_emails = contact_emails.split(',').map(&:strip)
    end
  end
end