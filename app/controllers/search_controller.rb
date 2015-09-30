class SearchController < ApplicationController
  def nearby
    if current_user
      @spots = Spot.near([current_user.latitude, current_user.longitude],5)
    else
      @spots = Spot.near([session[:latitude], session[:longitude]],5)
    end
    @title = 'Nearby Parking Spots'
    @subtitle = 'The nearest parking spots are below!'
  end
end
