class ElevationsController < ApplicationController
  def index
    render json: elevations_cache
  end

  private

  def elevations_cache
    Rails.cache.fetch('elevations', expires_in: 1.hour) do
      Elevation.all
    end
  end
end
