class LikesController < ApplicationController
  def update
    like = Like.where(blog: Blog.find(params[:blog]), user: current_user)
    if like == []
      # If user doesn't like this post, then create a like
      Like.create(blog: Blog.find(params[:blog]), user: current_user)
      @like_exists = true
    else
      # If it exists, then delete it
      like.destroy_all
      @like_exists = false
    end
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end
end
