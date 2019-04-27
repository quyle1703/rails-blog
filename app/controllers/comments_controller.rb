class CommentsController < ApplicationController
  before_action :set_blog
  before_action :authenticate_user!

  def create
    @comment = @blog.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
  end

  def destroy
    @comment = @blog.comments.find(params[:id])
    @comment_id = @comment.id
    @comment.destroy
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :blog_id)
  end
  def set_blog
    @blog = Blog.find(params[:blog_id])
  end
end
