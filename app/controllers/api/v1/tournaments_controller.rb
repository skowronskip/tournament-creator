class Api::V1::TournamentsController < ApplicationController
  skip_before_action :authenticate_request, only: %i[index destroy tournament_statistics]
  def index
    render json: Tournament.all
  end

  def get_my_tournaments
    tournaments = Tournament.where(user_id: current_user.id).includes(:participants, :matches).as_json(include: [:participants, :matches])
    render json: tournaments
  end

  def get_one_tournament
    tournaments = Tournament.where(user_id: current_user.id, id: params[:id]).includes(:participants, :matches).as_json(include: [:participants, :matches])
    render json: tournaments[0]
  end

  def create
    puts current_user
    tournament = Tournament.create({name: tournament_params[:name], game_id: tournament_params[:game_id], user_id: current_user.id})
    tournament = Tournament.where(id: tournament.id).includes(:participants).as_json(include: :participants)
    if tournament[0]
      render json: tournament[0]
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
    tournament = Tournament.where(user_id: current_user.id, id: params[:id]).includes(:participants).as_json(include: :participants)
    render json: tournament[0]
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
    params.require(:tournament).permit(:id, :name, :game, :game_id, :type, :state);
  end
end