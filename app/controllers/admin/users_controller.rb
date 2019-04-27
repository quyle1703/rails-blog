class Admin::UsersController < ApplicationController
  layout 'admin'
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :require_admin

  def index
    @users = User.paginate(:page => params[:page], :per_page => 5).order(created_at: :desc)
    # @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to admin_users_url
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to admin_users_url
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "User destroyed."
    redirect_to admin_users_path
  end


  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # Before filters

    def set_user
      @user = User.find(params[:id])
    end

    def require_admin
      if !current_user.try(:admin?)
        redirect_to blogs_path
      end
    end
  
  end
