class Api::V1::MatchesController < ApplicationController
  def index
    render json: Match.all
  end

  def create
    match = Match.create(match_params)
    if match.id
      render json: match
    else
      render json: false
    end
  end

  def destroy
    Match.destroy(params[:id])
  end

  def update
    match = Match.find(params[:id])
    match.update_attributes(match_params)
    match = Match.find(params[:id])
    render json: match
  end

  private

  def match_params
    params.require(:match).permit(:id, :homePoints, :awayPoints, :home_team_id, :away_team_id);
  end
end