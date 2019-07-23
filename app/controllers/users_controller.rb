class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: :create

  def index
    @users = User.all
  end

  def show
    #@user = User.find(params[:id])
    #@article = Article.find(params[:article_id])
    #@users = @article.users
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: 'User was successfully created.' 
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.' 
    else
      render :edit  
    end
  end

  
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :fullname, :contactNumber,:password, :password_confirmation, :current_password, :username, :role)
    end

    def authorize_admin
    return unless !current_user.user?
    redirect_to root_path, alert: 'Admins only!'
  end
end
