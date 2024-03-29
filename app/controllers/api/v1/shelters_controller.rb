class Api::V1::SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
    render json: @shelters
  end

  def show
    @shelter = Shelter.find(params[:id])
    render json: @shelter
  end
end