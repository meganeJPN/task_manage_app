class UsersController < ApplicationController
  def new
    if logged_in?
      redirect_to user_path(current_user.id)
    else
      @user = User.new
    end
    
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to tasks_path, notice: "#{@user.name}を登録しました！"
    else
      render :new
    end
  end

  def show
    if logged_in?
      # binding.irb
      if params[:id].to_i == current_user.id
        @user = current_user
      else
        redirect_to tasks_path
      end
    else 
      redirect_to new_session_path
    end
    
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  
end
