class Post < ApplicationRecord
  has_many :likes
  has_many :comments
  belongs_to :author_id, class_name: 'User'

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_save :increment_author_posts_counter

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def increment_author_posts_counter
    author_id.increment!(:posts_counter)
  end
end
