require 'rails_helper'

RSpec.describe Comment, type: :model do
  user = User.create(
    name: 'Kene',
    photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
    bio: 'full stack developer',
    posts_counter: 0
  )

  post = Post.create(
    title: 'my title',
    text: 'Hello World!',
    comments_counter: 0,
    likes_counter: 0,
    author_id_id: user.id
  )

  Comment.create(
    author_id_id: user.id,
    post_id: post.id,
    text: 'A nice post'
  )

  context '#increment_post_comments_counter' do
    it 'increments post comments counter by 1' do
      expect(Post.find(post.id).comments_counter).to eq(1)
    end
  end
end
