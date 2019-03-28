class Api::V1::TournamentsController < ApplicationController
  def index
    render json: Tournament.all
  end

  def create
    tournament = Tournament.create(tournament_params)
    if tournament.id
      render json: tournament
    else
      render json: false
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
    params.require(:tournament).permit(:id, :name, :type);
  end
end