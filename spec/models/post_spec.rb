require 'rails_helper'

RSpec.describe Post, type: :model do
  user = User.create(
    name: 'Kene',
    photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
    bio: 'Full stack engineer',
    posts_counter: 0
  )

  post = Post.create(
    title: 'my title',
    text: 'Hello World!',
    comments_counter: 0,
    likes_counter: 0,
    author_id_id: user.id
  )

  7.times.collect do
    Comment.create(
      post_id: post.id,
      author_id_id: user.id,
      text: 'My comment text'
    )
  end

  context '#five_recent_comments' do
    it 'returns 5 recents comments' do
      expect(post.recent_comments.length).to eql(5)
    end

    it 'return at most 5 comments' do
      expect(post.recent_comments.length).to be_between(0, 5).inclusive
    end
  end

  context '#increment_author_posts_counter' do
    it 'increments posts counter by 1' do
      expect(User.find(user.id).posts_counter).to eq(1)
    end
  end
end