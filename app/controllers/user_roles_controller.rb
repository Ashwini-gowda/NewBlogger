class UserRolesController < ApplicationController
  before_action :set_user_role, only: [:show, :edit, :update]
  before_action :authorize_admin!
  def index
    @user_roles = UserRole.all
  end

  def show
  end

  def new
    @user_role = UserRole.new
  end

  def edit
  end

  def create
    @user_role = UserRole.new(user_role_params)
    if @user_role.save
      redirect_to @user_role, notice: 'User role was successfully created.' 
    else
      render :new 
    end
  end

  def update
    if @user_role.update(user_role_params)
      redirect_to @user_role, notice: 'User role was successfully updated.' 
    else
      render :edit 
    end
  end
 
  private
    def set_user_role
      @user_role = UserRole.find(params[:id])
    end

    def user_role_params
      params.require(:user_role).permit(:name, :parent_role_id)
    end

    def authorize_admin
    return unless !current_user.admin?
    redirect_to root_path, alert: 'Admins only!'
  end
end
