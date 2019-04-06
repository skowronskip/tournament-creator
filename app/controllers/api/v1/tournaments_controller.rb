class Api::V1::TournamentsController < ApplicationController
  skip_before_action :authenticate_request, only: %i[index destroy update tournament_statistics]
  def index
    render json: Tournament.all
  end

  def get_my_tournaments
    tournaments = Tournament.where(user_id: current_user.id)
    render json: tournaments
  end

  def create
    puts current_user
    tournament = Tournament.create({name: tournament_params[:name], game_id: tournament_params[:game_id], user_id: current_user.id})
    if tournament.id
      render json: tournament
    else
      render json: false, status: :unauthorized
    end
  end

  def destroy
    Tournament.destroy(params[:id])
  end

  def update
    tournament = Tournament.find(params[:id])
    tournament.update_attributes(tournament_params)
    tournament = Tournament.find(params[:id])
    render json: tournament
  end

  def tournament_statistics
    tournament_id = params[:tournament_id]
    if tournament_id == nil
      render json: { error: 'No tournament id' }
    else
      tournament = Tournament.find(tournament_id)
      calculator = CalculateTournamentTable.new(tournament.participants)
      render json: calculator.call
      begin

      rescue
        render json: { error: 'There is no such torunament' }
      end
    end
  end

  private

  def tournament_params
    params.require(:tournament).permit(:id, :name, :game, :game_id, :type);
  end
end