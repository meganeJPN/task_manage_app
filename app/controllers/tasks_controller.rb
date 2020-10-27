class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all.order(created_at: "DESC")
   
    @task_search_params = task_search_params
    @tasks = Task.search(@task_search_params)
    @tasks = @tasks.order(deadline: "DESC") if params[:sort_expired_deadline].present?
    @tasks = @tasks.order(priority: "DESC") if params[:sort_expired_priority].present?
    @tasks = @tasks.page(params[:page]).per(10)
    # @tasks = @tasks.where('name LIKE ?', "%#{@task_search_params[:name]}%") if @task_search_params[:name].present?
    # @tasks = @tasks.where(status: @task_search_params[:status]) if @task_search_params[:status].present?
    
    # binding.irb
    
    # if params[:task].present?
    #   if params[:name].present? && params[:status].present?
    #   elsif params[:name].present?
    #   elsif params[:status].present?
    #   end
    # end

  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
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
    params.require(:task).permit(:name, :content, :deadline).merge(status: params[:task][:status].to_i, priority: params[:task][:priority].to_i)
  end

  def task_search_params
    params.fetch(:search,{}).permit(:name,:status)
  end
end
