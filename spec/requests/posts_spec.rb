require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:user) do
    User.create(
      name: 'Kene',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Full stack engineer',
      posts_counter: 0
    )
  end

  let(:post) do
    Post.create(
      title: 'Title',
      text: 'Hello World!',
      comments_counter: 0,
      likes_counter: 0,
      author_id_id: user.id
    )
  end

  context 'GET #index' do
    before(:example) { get user_posts_path(user) }

    it 'is successful' do
      expect(response).to have_http_status(:ok)
    end

    context 'index template' do
      it 'is rendered' do
        expect(response).to render_template('index')
      end

      it 'has response body that include the correct placeholder text' do
        expect(response.body).to include('Here is the List of post for a given user')
      end
    end
  end

  context 'GET #show' do
    before(:example) { get user_post_path(user, post) }

    it 'is successful' do
      expect(response).to have_http_status(:ok)
    end

    context 'show template' do
      it 'is rendered' do
        expect(response).to render_template('show')
      end

      it 'has response body that includes correct placeholder text' do
        expect(response.body).to include('Post detials')
      end
    end
  end
end
