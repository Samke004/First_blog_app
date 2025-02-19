class Relationship < ApplicationRecord
    belongs_to :follower, class_name: "User"
    belongs_to :followed, class_name: "User"
    validates :follower_id, uniqueness: { scope: :followed_id }
    validate :cannot_follow_self
    after_create :notify_followed_user


    def cannot_follow_self
        if follower_id == followed_id
          errors.add(:followed_id, "ne možete pratiti sami sebe")
        end
      end

    def notify_followed_user
        Notification.create!(
          recipient: followed,
          notifiable: follower
        )
      end
end


