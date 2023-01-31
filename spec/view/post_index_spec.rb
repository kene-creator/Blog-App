require 'rails_helper'

RSpec.describe 'Render post index page', type: :system do
  before do
    @user = User.create(id: 30, name: 'Tom', photo: 'http://placeimg.com/640/480/any', bio: 'Teacher from Mexico.',
                        posts_counter: 0)
    @first_post = Post.create(author_id: @user, title: 'Hello', text: 'This is my first post.', likes_counter: 0,
                              comments_counter: 0)
    Comment.create(text: 'Good boy!', author_id_id: @user, post_id: @first_post.id)
    Comment.create(text: 'Good boy!', author_id_id: @user, post_id: @first_post.id)
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
      visit('/users/30/posts/')
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

    it "display the user's profile image" do
      Capybara.visit "/users/#{@user.id}/posts/"
      expect(page).to have_selector("img[src*='#{@user.photo}']")
    end

    it "display the user's name" do
      Capybara.visit "/users/#{@user.id}/posts/"
      expect(page).to have_content(@user.name)
    end

    it 'displays number of posts from the user' do
      Capybara.visit "/users/#{@user.id}/posts/"
      expect(page).to have_content("Number of posts: #{@user.posts_counter}")
    end

    it 'displays section for pagination' do
      Capybara.visit "/users/#{@user.id}/posts/"
      expect(page).to have_content('Pagination')
    end


    it 'should redirect to the users profile page' do
      Capybara.visit "/users/#{@user.id}/posts/"
      click_link(@first_post.title.to_s)
      expect(page).to have_current_path("/users/#{@user.id}/posts/#{@first_post.id}")
    end
  end
end
