class ElevationsController < ApplicationController
  def index
    render json: Elevation.all
  end
end
