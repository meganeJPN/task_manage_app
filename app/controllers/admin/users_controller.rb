class Admin::UsersController < ApplicationController
  before_action :not_admin_or_not_login_redirect
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

  def show
    @user = User.find_by(id: params[:id].to_i) 
  end


  def destroy
    User.find(params[:id]).destroy
    redirect_to admin_users_path, notice: "ユーザーを削除しました！"
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def not_admin_or_not_login_redirect
    redirect_to new_session_path unless logged_in?
    redirect_to tasks_path unless current_user.admin?
  end

end
