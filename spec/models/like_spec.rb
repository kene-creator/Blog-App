require 'rails_helper'

RSpec.describe Like, type: :model do
  user = User.create(
    name: 'Kene',
    photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
    bio: 'fullstack engineer',
    posts_counter: 0
  )

  post = Post.create(
    title: 'my title',
    text: 'Hello World!',
    comments_counter: 0,
    likes_counter: 0,
    author_id_id: user.id
  )

  Like.create(author_id_id: user.id, post_id: post.id)

  context '#increment_post_likes_counter' do
    it 'increments post likes counter by 1' do
      expect(Post.find(post.id).likes_counter).to eq(1)
    end
  end
end
