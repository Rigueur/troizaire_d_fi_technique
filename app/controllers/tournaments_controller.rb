class TournamentsController < ApplicationController
  require 'faker'
  def index
    @tournaments = Tournament.all
  end

  def create
    @tournament = Tournament.new

    if @tournament.save
      redirect_to @tournament
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @tournament = Tournament.find(params[:id])
  end

  def seed_teams
    @tournament = Tournament.find(params[:id])

    # Destroy all participations related to this tournament
    @tournament.participations.destroy_all

    # Destroy all matches related to this tournament
    @tournament.matches.destroy_all

    8.times do
      team = Team.create(name: Faker::Team.name, city: Faker::Address.city)
      Participation.create(tournament: @tournament, team: team)
      11.times do
        Player.create(
          name: Faker::FunnyName.name,
          role: %w[heal tank DPS].sample,
          team: team
        )
      end
    end
    flash.notice = 'Teams and players have been seeded.'
    redirect_to request.referrer
  end

  def seed_matches
    @tournament = Tournament.find(params[:id])
    teams = @tournament.teams.to_a

    # Destroy all matches related to this tournament
    @tournament.matches.destroy_all

    teams.combination(2).each do |team_a, team_b|
      team_a_kill = rand(0..5)
      team_b_kill = rand(0..5)
      team_a_point, team_b_point = if team_a_kill > team_b_kill
                                     [3, 0]
                                   elsif team_a_kill < team_b_kill
                                     [0, 3]
                                   else
                                     [1, 1]
                                   end

      Match.create(
        tournament: @tournament,
        team_a: team_a,
        team_b: team_b,
        team_a_kill: team_a_kill,
        team_b_kill: team_b_kill,
        team_a_point: team_a_point,
        team_b_point: team_b_point
      )
    end

    flash.notice = 'Matches have been seeded.'
    redirect_to request.referrer
  end

  def result
    @tournament = Tournament.find(params[:id])
  end

  def participation
    @tournament = Tournament.find(params[:id])
    @teams = Team.all
  end

  def participate
    @tournament = Tournament.find(params[:id])

    # Destroy all matches related to this tournament
    @tournament.matches.destroy_all

    @tournament.teams = Team.find(params[:team_ids].split(',').map(&:to_i))
    if @tournament.save
      redirect_to @tournament, notice: 'Teams were successfully added.'
    else
      render :participation
    end
  end
end
