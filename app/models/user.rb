class User < ApplicationRecord
  # Include default Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :posts, dependent: :destroy

  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed

  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :contact_emails, dependent: :destroy
  accepts_nested_attributes_for :contact_emails, allow_destroy: true
  before_save do
    puts "Before Save: #{contact_emails.inspect}"
  end

  # Validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  # Callbacks
  before_save :normalize_contact_emails

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

  def normalize_contact_emails
    contact_emails.each do |contact_email|
      contact_email.email = contact_email.email.strip.downcase if contact_email.email.present?
    end
  end

  mount_uploader :profile_picture, ProfilePictureUploader
end
