class UsersController < ApplicationController
  before_action :authenticate_user!

  def authenticate_user!
    redirect_to '/users/sign_in' unless current_user
  end

  def index
    @users = User.all
  end

  def show
    @user = User.includes(:posts).find_by(id: params[:id])
  end
end
