class User < ApplicationRecord
  # Include default Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed

  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  # Validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  # Callbacks
  before_save :parse_contact_emails

  # Methods
  def full_name
    "#{first_name} #{last_name}"
  end

  def follow(other_user)
    return if self == other_user # Prevent following self
    following << other_user unless following?(other_user)
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  # Overriding Devise method to find user by primary email only
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    email = conditions.delete(:email)

    # Search only by primary email
    where(conditions).where(email: email).first
  end

  private

  def parse_contact_emails
    if contact_emails.is_a?(String)
      self.contact_emails = contact_emails.split(',').map(&:strip)
    end
  end

  mount_uploader :profile_picture, ProfilePictureUploader
end
