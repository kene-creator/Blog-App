class PostsController < ApplicationController
  def index
    author_id = posted_by
    @user = User.includes(:posts, :comments).find(author_id)
    @posts = Post.includes(:author_id).where(author_id:)
  end

  def show
    author_id = posted_by
    @user = User.find(author_id)
    @post = Post.where(author_id:).first
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(**post_params, author_id_id: current_user.id)

    if @post.save
      flash[:success] = 'Post made successfully'
      redirect_to "/users/#{@post.author_id.id}/posts/#{@post.id}"
    else
      flash.now[:error] = 'Error: Post could not be saved'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def posted_by
    params[:user_id]
  end
end
