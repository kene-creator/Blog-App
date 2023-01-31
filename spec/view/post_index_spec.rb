require 'rails_helper'

RSpec.describe 'Render post index page', type: :system do
  before do
    @user = User.create(id: 30, name: 'Tom', photo: 'http://placeimg.com/640/480/any', bio: 'Teacher from Mexico.', posts_counter: 0)
    @first_post = Post.create(author_id: @user, title: 'Hello', text: 'This is my first post.', likes_counter: 0, comments_counter: 0)
    @second_post = Post.create(author_id: @user, title: 'Hello', text: 'This is my second post.', likes_counter: 0, comments_counter: 0)
    Comment.create(text: 'Good boy!', author_id_id: @user, post_id: @first_post.id)
    Comment.create(text: 'Good boy!', author_id_id: @user, post_id: @second_post.id)
    @comment_list = @first_post.recent_comments.each do |comment| comment.text end
  end

  describe 'index post page' do
    it 'displays post text' do
      visit('/users/30/posts/')
      expect(page).to have_content('This is my first post.')
    end

    it 'display the post title' do
      visit('/users/30/posts/')
      expect(page).to have_content(@first_post.title)
    end

    it 'display the post body' do
      visit('/users/30/posts/')
      expect(page).to have_content(@first_post.text)
    end

    it 'display the first comment on a post' do
      visit("/users/30/posts/")
      expect(page).to have_content('Comments List')
    end

    it 'display the how many comments' do
      visit('/users/30/posts/')
      expect(page).to have_content(@first_post.comments_counter)
    end

    it 'display how many Likes' do
      visit('/users/30/posts/')
      expect(page).to have_content('Likes: 0')
    end
  end
end