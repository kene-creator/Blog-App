class Comment < ApplicationRecord
    belongs_to :post
    belongs_to :author_id, class_name: 'User'

    after_save :increment_post_comments_counter

  private

  def increment_post_comments_counter
    post.increment!(:comments_counter)
  end
end
