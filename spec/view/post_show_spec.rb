require 'rails_helper'

RSpec.describe 'visit the post show page', type: :system do
  before do
    @user = User.create(id: 30, name: 'Tom', photo: 'https://randomuser.me/api/portraits/men/23.jpg',
                        bio: 'Teacher from Mexico.', posts_counter: 0)
    @first_post = Post.create(author_id: @user, title: 'Hello', text: 'This is my first post.', likes_counter: 0,
                              comments_counter: 0)
    @second_post = Post.create(author_id: @user, title: 'Hello', text: 'This is my second post.', likes_counter: 0,
                               comments_counter: 0)
    Comment.create(post: @first_post, author_id: @user, text: 'Good boy!')
    Comment.create(post: @first_post, author_id: @user, text: 'Good boy!')
    Comment.create(post: @first_post, author_id: @user, text: 'Good boy!')
  end

  describe 'show post page' do
    it 'displays the post title' do
      visit '/'
      click_on @user.name
      expect(page).to have_content(@first_post.title)
    end

    it 'shows the person who wrote the post' do
      visit '/'
      click_on @user.name
      expect(page).to have_content('Tom')
    end

    it 'can see the username of each commentor.' do
      visit '/'
      click_on @user.name
      expect(page).to have_content('Tom')
    end

    it 'displays number of comments' do
      visit('/users/30/posts/')
      expect(page).to have_content('Comments: 3')
    end

    it 'displays number of likes' do
      visit('/users/30/posts/')
      expect(page).to have_content('Likes: 0')
    end

    it 'displays the content of the post' do
      visit '/'
      click_on @user.name
      expect(page).to have_content(@first_post.text)
    end

    it 'displays the comments of each commentor.' do
      visit('/users/30/posts/')
      expect(page).to have_content 'Good boy!'
      expect(page).to have_content 'Good boy!'
      expect(page).to have_content 'Good boy!'
    end
  end
end
