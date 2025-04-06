class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  validates :content, presence: true

  after_create :notify_post_author

  private

  def notify_post_author
    return if post.user == user # Ne šaljemo obavijest ako korisnik komentira svoju objavu

    NotificationJob.perform_later(self, post.user)
  end
end
