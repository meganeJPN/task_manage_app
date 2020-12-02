class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :not_login_redirect_to_new_session,only: [:index,:show,:create,:edit,:update,:destroy]

  def index
    @tasks = Task.eager_load(:users).where(users: {id: current_user.id}).order(created_at: "DESC")
    @task_search_params = task_search_params
    @tasks = current_user.tasks.search(@task_search_params)
    @tasks = @tasks.order(deadline: "DESC") if params[:sort_expired_deadline].present?
    @tasks = @tasks.order(priority: "DESC") if params[:sort_expired_priority].present?
    # binding.irb
    # @tasks = @tasks.where(id: params[:search][:label_id])
    @tasks = @tasks.joins(:labels).where(labels: { id: params[:search][:label_id] }) if params.dig(:search, :label_id)
    @tasks = @tasks.page(params[:page]).per(10)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    # @task = Task.new(task_params)
    # @task.user_id = current_user.id
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_path, notice: "タスクを登録しました！"
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを更新しました！"
    else
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました！"
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :content, :deadline, { label_ids: [] }).merge(status: params[:task][:status].to_i, priority: params[:task][:priority].to_i)
  end

  def task_search_params
    params.fetch(:search,{}).permit(:name,:status,:label_id)
  end

  def not_login_redirect_to_new_session
      redirect_to new_session_path unless logged_in?
  end
end
