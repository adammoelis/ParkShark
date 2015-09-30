class SearchController < ApplicationController
  def nearby
    if params[:q]
      @spots = Spot.near(params[:q], 10)
    elsif current_user
      @spots = Spot.near([current_user.latitude, current_user.longitude], 10)
    else
      @spots = Spot.near([session[:latitude], session[:longitude]], 10)
    end
    @title = 'Nearby Parking Spots'
    @subtitle = 'The nearest parking spots are below!'
  end
end
