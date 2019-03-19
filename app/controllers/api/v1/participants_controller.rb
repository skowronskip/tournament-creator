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

  private

  def participant_params
    params.require(:participant).permit(:id, :name, :tournament_id)
  end
end