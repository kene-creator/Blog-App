class Api::CommentsController < Api::ApiController
  respond_to :json

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments
    respond_with @comments
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(text: params[:text], author_id: current_user)
    if @comment.save
      respond_with @comment
    else
      render json: { errors: @comment.errors }, status: :unprocessable_entity
    end
  end
end
