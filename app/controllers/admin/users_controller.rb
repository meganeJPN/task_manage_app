class Admin::UsersController < ApplicationController
  before_action :not_admin_or_not_login_redirect
  before_action :set_user, only: [:edit,:show, :update, :destroy]
  
  def index
    @users = User.all.order(created_at: "ASC") 
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice:"#{@user.name}を作成しました"
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "#{@user.name}の情報を更新しました！"
    else
      render :edit
    end
  end

  def show

  end

  def destroy
    if @user.destroy
      flash[:notice] = "アカウント#{@user.name}を削除しました！"
    else
      flash[:notice] =  "管理者権限のアカウントが１つしかないため、この管理者権限を持ったアカウントを削除できません"
    end
    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def not_admin_or_not_login_redirect
    redirect_to new_session_path unless logged_in?
    redirect_to tasks_path,notice: "管理者以外はアクセスできません" unless current_user.admin?
  end

end