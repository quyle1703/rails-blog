class Admin::BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :require_admin
  layout 'admin'

  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = Blog.paginate(:page => params[:page], :per_page => 5).order(created_at: :desc)
    # @blogs = Blog.all
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
    @like_exists = Like.where(blog: @blog, user: current_user) == [] ? false : true
    @comment = Comment.new
    @comments= @blog.comments.order("created_at DESC")
  end

  # GET /blogs/new
  def new
    @blog = current_user.blogs.build
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = current_user.blogs.build(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to admin_blogs_path }
        flash[:notice] = "Blog was successfully created."
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        flash[:notice] = "Blog was successfully updated."
        format.html { redirect_to admin_blogs_url }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to admin_blogs_path }
      flash[:notice] = "Blog was successfully updated."
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:title, :content, :image)
    end

    def require_admin
      if !current_user.try(:admin?)
        redirect_to blogs_path
      end
    end
end
