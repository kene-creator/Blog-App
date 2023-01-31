require 'rails_helper'

RSpec.describe 'user profile page', type: :system do
  before do
    @user1 = User.create(id: 30, name: 'Tom', photo: 'http://placeimg.com/640/480/any', bio: 'Teacher.',
                         posts_counter: 0)
    @user2 = User.create(id: 31, name: 'Lilly', photo: 'http://placeimg.com/640/480/any', bio: 'Barista.',
                         posts_counter: 0)
    @post1 = Post.create(author_id: @user1, title: 'My first post.', text: 'My post description.', comments_counter: 0,
                         likes_counter: 0)
    @post2 = Post.create(author_id: @user2, title: 'My second post.', text: 'My post description.',
                         comments_counter: 0, likes_counter: 0)
    @post3 = Post.create(author_id: @user1, title: 'My third post.', text: 'My post description.', comments_counter: 0,
                         likes_counter: 0)
    Comment.create(post: @post1, author_id_id: @user2, text: 'Good boy!')
    Comment.create(post: @post2, author_id_id: @user1, text: 'Good girl!')
  end

  it "display the user's profile image" do
    Capybara.visit "/users/#{@user1.id}"
    expect(page).to have_selector("img[src*='#{@user1.photo}']")
  end

  it 'display link that helps me view all user post' do
    Capybara.visit "/users/#{@user1.id}"
    expect(page).to have_link('See all posts')
  end

  it "display the user's name" do
    Capybara.visit "/users/#{@user1.id}"
    expect(page).to have_content(@user1.name)
  end

  it 'displays number of posts from the user' do
    Capybara.visit "/users/#{@user1.id}"
    expect(page).to have_content("Number of posts: #{@user1.posts_counter}")
  end

  it 'displays the user\'s bio' do
    Capybara.visit "/users/#{@user1.id}"
    expect(page).to have_content(@user1.bio)
  end

  it 'displays 3 recent posts' do
    Capybara.visit "/users/#{@user1.id}"
    expect(page).to have_content(@post1.text)
    expect(page).to have_content(@post2.text)
    expect(page).to have_content(@post3.text)
  end

  it 'should redirect to the users profile page' do
    Capybara.visit "/users/#{@user1.id}"
    click_link('See all posts')
    expect(page).to have_current_path("/users/#{@user1.id}/posts")
  end

  it 'should redirect to the post show page' do
    Capybara.visit "/users/#{@user1.id}"
    click_link("#{@post1.title}")
    expect(page).to have_current_path("/users/#{@user1.id}/posts")
  end
end
