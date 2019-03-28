class Api::V1::ParticipantsController < ApplicationController
  def index
    render json: Participant.all
  end

  def create
    participant = Participant.create(participant_params)
    if participant.id
      render json: participant
    else
      render json: false
    end
  end

  def destroy
    Participant.destroy(params[:id])
  end

  def update
    participant = Participant.find(params[:id])
    participant.update_attributes(participant_params)
    participant = Participant.find(params[:id])
    render json: participant
  end

  def team_statistics
    team_id = params[:team_id]
    if team_id == nil
      render json: { error: 'No team id' }
    else
      begin
        team = Participant.find(team_id)
        team_statistics = CalculateTeamStatistics.new(team, team.as_home_team, team.as_away_team)
        render json: team_statistics.call
      rescue
        render json: { error: 'There is no such team' }
      end
    end
  end

  private

  def participant_params
    params.require(:participant).permit(:id, :name, :tournament_id)
  end
end