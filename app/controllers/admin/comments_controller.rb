class Admin::CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :require_admin
  layout 'admin'
  def index
    @comments = Comment.paginate(:page => params[:page], :per_page => 10).order(created_at: :desc)
  end 

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to admin_comments_path }
      flash[:notice] = "Blog was successfully deleted."
      format.json { head :no_content }
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :blog_id)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def require_admin
    if !current_user.try(:admin?)
      redirect_to blogs_path
    end
  end
end
