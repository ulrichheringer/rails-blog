class BlogPost < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  has_one_attached :cover_image
  has_rich_text :content

  scope :sorted, -> { order(created_at: :desc, updated_at: :desc) }
  scope :draft, -> { where(published_at: nil) }
  scope :published, -> { where("published_at <= ?", Time.current) }
  scope :scheduled, -> { where("published_at >= ?", Time.current) }

  def draft?
    published_at.nil?
  end

  def published?
    published_at? && published_at <= Time.current
  end

  def scheduled?
    published_at? && published_at >= Time.current
  end
end
