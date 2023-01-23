class PostsController < ApplicationController
  def index
    author_id = posted_by
    @posts = Post.where(author_id:)
  end

  def show
    author_id = posted_by
    @post = Post.where(id: params[:id], author_id:).order(id: :DESC).first
  end

  def posted_by
    params[:user_id]
  end
end
