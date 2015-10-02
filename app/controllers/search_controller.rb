class SearchController < ApplicationController
  def nearby
    if params[:q] && params[:radius]
      @spots = Spot.near(params[:q], params[:radius])
    elsif params[:q]
      @spots = Spot.near(params[:q], Spot.default_search_distance)
    elsif current_user
      @spots = Spot.near([current_user.latitude, current_user.longitude], Spot.default_search_distance)
    else
      @spots = Spot.near([session[:latitude], session[:longitude]], Spot.default_search_distance)
    end
    @title = 'Nearby Parking Spots'
    @subtitle = 'The nearest parking spots are below!'
  end
end
