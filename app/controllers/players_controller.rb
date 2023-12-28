class PlayersController < ApplicationController
  def index
    @players = Player.all
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      flash.notice = "Player created !"
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def assign
    @players = Player.all
    @teams = Team.all
  end

  def assign_team
    player = Player.find(params[:assignment][:player_id])
    team = Team.find(params[:assignment][:team_id])

    if team.players.size >= 11
      flash.notice = "A team can't have more than 11 players"
    elsif player.update(team: team)
      flash.notice = "Player assigned !"
    else
      flash.notice = "Not a valid assignment"
    end

    redirect_to request.referrer
  end

  private

  def player_params
    params.require(:player).permit(:name, :role)
  end
end
