# require 'rails_helper'

# RSpec.describe "Users", type: :request do
#   describe "GET /users" do
#     it "works! (now write some real specs)" do
#       get users_index_path
#       expect(response).to have_http_status(200)
#     end
#   end
# end

require 'rails_helper'

RSpec.describe UsersController, type: :request do
  let(:user) do
    User.create(
      name: 'Kene',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Full stack developer',
      posts_counter: 0
    )
  end


  context 'GET #index' do
    before(:example) { get users_path }

    it 'returns a success response and renders index template' do
      get users_path
      expect(response).to be_successful
      expect(response).to render_template('index')
    end

    context 'index template' do

      it 'template placeholder has' do
        expect(response.body).to include('List of users')
      end
    end
  end

  context 'GET #show' do
    before(:example) { get user_path(user) } 

    it 'is successful' do
      expect(response).to have_http_status(:ok)
    end

    context 'show template' do
      it 'is rendered' do
        expect(response).to render_template('show')
      end

      it 'has response body that includes correct placeholder text' do
        expect(response.body).to include('User detials')
      end
    end
  end
end
