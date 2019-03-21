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

  def generate_matches
    tournament_id = params[:tournament_id]
    if tournament_id == nil
      render json: {error: 'No tournament id'}
    else
      participants = Tournament.find(tournament_id).participants
      if participants == nil
        render json: {error: 'Tournament has no participants'}
      else
        generator = GenerateMatches.new(participants, tournament_id)
        render json: generator.call
      end
    end
  end

  private

  def match_params
    params.require(:match).permit(:id, :homePoints, :awayPoints, :home_team_id, :away_team_id, :tournament_id);
  end
end