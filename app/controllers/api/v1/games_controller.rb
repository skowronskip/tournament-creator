class Api::V1::GamesController < ApplicationController
  skip_before_action :authenticate_request, only: %i[index]
  def index
    render json: Game.all
  end
end