require 'rails_helper'

RSpec.describe 'visit the user home page', type: :system do
  before do
    @user1 = User.create(id: 30, name: 'Tom', photo: 'http://placeimg.com/640/480/any', bio: 'Teacher.', posts_counter: 0)
    @user2 = User.create(id: 31, name: 'Lilly', photo: 'http://placeimg.com/640/480/any', bio: 'Barista.', posts_counter: 0)
    @post1 = Post.create(author_id: @user1, title: 'My first post.', text: 'My post description.', comments_counter: 0, likes_counter: 0)
    @post2 = Post.create(author_id: @user2, title: 'My second post.', text: 'My post description.', comments_counter: 0, likes_counter: 0)
    @post3 = Post.create(author_id: @user1, title: 'My third post.', text: 'My post description.', comments_counter: 0, likes_counter: 0)
    Comment.create(post: @post1, author_id: @user2, text: 'Good boy!')
    Comment.create(post: @post2, author_id: @user1, text: 'Good girl!')
  end

  describe 'index page' do
    it 'shows the username of all other users' do
      Capybara.visit '/'
      expect(page).to have_content(@user1.name)
    end

    it 'show the profile picture for each user' do
      Capybara.visit '/'
      expect(page).to have_selector("img[src*='#{@user1.photo}']")
    end

    it 'shows number of posts each user has written' do
      Capybara.visit '/'
      expect(page).to have_content("Number of posts: #{@user1.posts_counter}")
    end

    it 'directs to the users profile page' do
      Capybara.visit '/'
      click_on @user2.name
      expect(page).to have_current_path("/users/#{@user2.id}")
    end
  end
end