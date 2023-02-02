class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end

  def create
    comment = Comment.new(**comment_params, author_id_id: current_user.id, post_id: params[:post_id])

    if comment.save
      flash[:success] = 'Comment added successfully'
      redirect_to user_post_path(params[:user_id], params[:post_id])
    else
      flash.now[:error] = 'Error: Comment could not be saved'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @comment = Comment.find(params[:post_id])
    @comment.destroy
    redirect_to "/users/#{@post.author_id.id}/posts/", notice: "Comment was successfully deleted."
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
