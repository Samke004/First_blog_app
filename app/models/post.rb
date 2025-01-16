class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  mount_uploader :image, PostImageUploader

  # Scope za objavljene objave
  scope :published, -> { where(published: true).where("publication_date <= ?", Time.current) }

  # Scope za javno dostupne objave
  scope :public_posts, -> { published.where(public: true) }
end
