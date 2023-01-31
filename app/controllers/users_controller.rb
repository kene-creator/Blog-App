class UsersController < ApplicationController
  before_action :authenticate_user!

  def authenticate_user!
    redirect_to '/login' unless current_user
  end
  def index
    @users = User.all
  end

  def show
    @user = User.includes(:posts).find(params[:id])
  end
end
