class Admin::UsersController < ApplicationController
  before_action :not_admin_or_not_login_redirect
  before_action :set_user, only: [:edit, :update, :destroy]
  def index
    @users = User.all.order(created_at: "ASC") 
  end

  def new
    @user = User.new
  end

  def create
    binding.irb
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def edit

  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "ユーザーを削除しました！"
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def not_admin_or_not_login_redirect
    redirect_to new_session_path unless logged_in?
    redirect_to tasks_path unless current_user.admin?
  end

end
