class Api::V1::AnimalsController < ApplicationController
#   skip_before_action :verify_authenticity_token, only: [:update]

  def index
    @animals = Animal.all
    render json: @animals
  end

  def show
    @animal = Animal.find(params[:id])
    render json: @animal
  end

  def update
    @animal = Animal.find(params[:id])
    @animal.update_attributes(animal_param)
    render json: @animal
  end

end
