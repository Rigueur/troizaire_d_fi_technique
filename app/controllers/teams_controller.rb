class TeamsController < ApplicationController
  def index
    @teams = Team.all
  end

  def new
    @team = Team.new
  end

  def show
    @team = Team.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @team.players }
    end
  end

  def create
    @team = Team.new(team_params)

    if @team.save
      flash.notice = "Team created !"
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def team_params
    params.require(:team).permit(:name, :city)
  end
end
