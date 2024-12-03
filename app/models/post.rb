class Post < ApplicationRecord
  belongs_to :user

  validates :title, :short_description, :content, :publication_date, presence: true

  # Provjera da li je objava objavljena
  def published?
    published && publication_date <= Date.today
  end
end
