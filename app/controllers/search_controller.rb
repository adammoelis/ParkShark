class SearchController < ApplicationController
  def nearby
    sort_type = params[:sort_type] if params[:sort_type]
    start_time_filter = parse_time_format(params['listing']['beginning_time']) if params[:listing]
    beginning_time_of_day_filter = params['listing']['beginning_time_of_day'] if params[:listing]
    if params['listing'] && params['listing']['ending_time'] != ""
      end_time_filter = parse_time_format(params['listing']['ending_time'])
      ending_time_of_day_filter = params['listing']['ending_time_of_day']
    elsif start_time_filter
      end_time_filter = start_time_filter
    end
    price_filter = params[:price] if params[:price] && params[:price].size > 0
    if params[:q] && params[:radius]
      @spots = Spot.near(params[:q], params[:radius])
    elsif params[:q]
      @spots = Spot.near(params[:q], Spot.default_search_distance)
    else
      @spots = Spot.near(current_location, Spot.default_search_distance)
    end
    @spots = Search.for(@spots, start_time_filter, end_time_filter, price_filter, beginning_time_of_day_filter, ending_time_of_day_filter)
    @spots = sort(@spots, sort_type) if sort_type
    @title = 'Nearby Parking Spots'
    @subtitle = 'The nearest parking spots are below!'
  end

  private

  def spots_with_listings(spots_array)
      spots_array.select{|spot| spot.available_listings.size > 0}
  end

  def current_location
    if current_user
      [current_user.latitude, current_user.longitude]
    else
      [session[:latitude], session[:longitude]]
    end
  end

  def filter_price(spots_array, price_filter, start_time_filter, end_time_filter)
    spots_array.select do |spot|
      spot.available_listings.any? do |listing|
        listing.price <= price_filter.to_i && listing.is_available_between(start_time_filter, end_time_filter)
      end
    end
  end

  def filter_time(spots_array, start_time_filter, end_time_filter)
    spots_array.select do |spot|
      spot.available_listings.any? do |listing|
        listing.is_available_between(start_time_filter, end_time_filter)
      end
    end
  end

  def sort(spots_array, sort_type)
    if sort_type && sort_type == "Price"
      spots_with_listings(spots_array).sort{|a,b| a.lowest_price_listing.price <=> b.lowest_price_listing.price}
    elsif sort_type && sort_type == "Closest Time"
      spots_with_listings(spots_array).sort{|a,b| a.closest_time_listing.beginning_time <=> b.closest_time_listing.beginning_time}
    elsif sort_type && sort_type == "Closest Spot"
      spots_with_listings(spots_array).sort{|a,b| a.distance_from_location(current_location[0], current_location[1]) <=> b.distance_from_location(current_location[0], current_location[1])}
    end
  end

  def parse_time(type_of_time)
    year = params["listing"]["#{type_of_time}(1i)"]
    month = params["listing"]["#{type_of_time}(2i)"]
    day = params["listing"]["#{type_of_time}(3i)"]
    hour = params["listing"]["#{type_of_time}(4i)"]
    minute = params["listing"]["#{type_of_time}(5i)"]
    DateTime.parse("#{year}/#{month}/#{day} #{hour}:#{minute}")
  end

  def parse_time_format(time)
    array_of_time = time.split("/")
    month = array_of_time[0]
    day = array_of_time[1]
    year = array_of_time[2]
    DateTime.parse("#{year}/#{month}/#{day}")
  end


end
