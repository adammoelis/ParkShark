class SearchController < ApplicationController
  def nearby
    sort_type = params[:sort_type] if params[:sort_type]
    if params[:q] && params[:radius]
      @spots = Spot.near(params[:q], params[:radius])
    elsif params[:q]
      @spots = Spot.near(params[:q], Spot.default_search_distance)
    else
      @spots = Spot.near(current_location, Spot.default_search_distance)
    end
    if sort_type && sort_type == "Price"
      @spots = spots_with_listings(@spots).sort{|a,b| a.lowest_price_listing.price <=> b.lowest_price_listing.price}
    elsif sort_type && sort_type == "Closest Time"
      @spots = spots_with_listings(@spots).sort{|a,b| a.closest_time_listing.beginning_time <=> b.closest_time_listing.beginning_time}
    elsif sort_type && sort_type == "Closest Spot"
      @spots = spots_with_listings(@spots).sort{|a,b| a.distance_from_location(current_location[0], current_location[1]) <=> b.distance_from_location(current_location[0], current_location[1])}
    end
    @title = 'Nearby Parking Spots'
    @subtitle = 'The nearest parking spots are below!'
  end

  private

  def spots_with_listings(spots_array)
    @spots.select{|spot| spot.listings.size > 0}
  end

  def current_location
    if current_user
      [current_user.latitude, current_user.longitude]
    else
      [session[:latitude], session[:longitude]]
    end
  end


end
