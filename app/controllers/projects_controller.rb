class ProjectsController < ApplicationController
  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      flash.notice = "Project created !"
      redirect_to @project
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find_by(id: params[:id])
    @tasks = @project.tasks
    @tasks = @tasks.where(user_id: params[:user_id]) if params[:user_id].present?
    @tasks = @tasks.where(status: params[:status]) if params[:status].present?
  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
