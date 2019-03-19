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

  private

  def tournament_params
    params.require(:tournament).permit(:id, :name, :type);
  end
end