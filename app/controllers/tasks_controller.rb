class TasksController < ApplicationController
  before_action :set_project

  def new
    @task = @project.tasks.new
  end

  def create
    @task = @project.tasks.new(task_params)
    @task.project = @project
    if @task.save
      flash.notice = "Task created !"
      redirect_to @project
    else
      render "projects/show", status: :unprocessable_entity
    end
  end

  def assign_user
    @task = @project.tasks.find_by(id: params[:id])
    @user = User.find_by(id: params[:user_id])
    @task.user = @user
    if @task.save
      flash.notice = "User assigned !"
      redirect_to @project
    else
      render "projects/show", status: :unprocessable_entity
    end
  end

  def set_status
    @task = @project.tasks.find_by(id: params[:id])
    @task.status = params[:status]
    if @task.save
      flash.notice = "Status updated !"
      redirect_to @project
    else
      render "projects/show", status: :unprocessable_entity
    end
  end

  private

  def set_project
    @project = Project.find_by(id: params[:project_id])
  end

  def task_params
    params.require(:task).permit(:name, :description)
  end
end
