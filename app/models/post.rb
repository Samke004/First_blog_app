class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  mount_uploader :image, PostImageUploader

  # pg_search za pretragu po naslovu i kratkom sadržaju
  include PgSearch::Model
  pg_search_scope :search_by_title_and_content,
    against: [ :title, :short_content ],
    using: { tsearch: { prefix: true } }

  # Scope za objavljene objave
  scope :published, -> { where(published: true).where("publication_date <= ?", Time.current) }

  # Scope za javno dostupne objave
  scope :public_posts, -> { published.where(public: true) }

  # Scope za filtriranje prema vidljivosti (public ili private)
  scope :filter_by_visibility, ->(visibility) {
    case visibility
    when "public"
      public_posts
    when "private"
      where(public: false)
    else
      all
    end
  }

  # Scope za filtriranje prema datumu objave
  scope :filter_by_date_range, ->(from_date, to_date) {
    query = all
    query = query.where("publication_date >= ?", from_date) if from_date.present?
    query = query.where("publication_date <= ?", to_date) if to_date.present?
    query
  }
  def self.filter_records(filters = {})
  result = all
  result = result.search_by_title_and_content(filters[:search]) if filters[:search].present?
  result = result.filter_by_visibility(filters[:visibility]) if filters[:visibility].present?
  result = result.filter_by_date_range(filters[:from_date], filters[:to_date])
  result
end
end
