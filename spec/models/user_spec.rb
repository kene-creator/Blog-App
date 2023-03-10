require 'rails_helper'
RSpec.describe User, type: :model do
  user = User.create(
    name: 'Kene',
    photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
    bio: 'full stack engineer',
    posts_counter: 0
  )

  7.times.collect do
    Post.create(
      title: 'my title',
      text: 'Hello World!',
      comments_counter: 1,
      likes_counter: 0,
      author_id_id: user.id
    )
  end

  context '#three_recent_posts' do
    it 'should return three recent posts' do
      expect(user.recent_posts.length).to eql(3)
    end

    it 'return at most 3 posts' do
      expect(user.recent_posts.length).to be_between(0, 3).inclusive
    end
  end
end
