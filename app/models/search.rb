class Search < ActiveRecord::Base
  def self.for(spots_array, start_time, end_time, price_filter, beginning_time_of_day_filter, ending_time_of_day_filter)
    spots = self.spots_with_listings(spots_array)
    if !start_time
      spots
    elsif start_time == end_time
      spots = self.single_day_search(spots, start_time, beginning_time_of_day_filter, price_filter)
    else
      spots = self.multi_day_search(spots, start_time, beginning_time_of_day_filter, end_time, ending_time_of_day_filter, price_filter)
    end
  end

  def self.search_near(location, radius, current_location)
    if location && radius
      @spots = Spot.near(location, radius)
    elsif location
      @spots = Spot.near(location, Spot.default_search_distance)
    else
      @spots = Spot.near(current_location, Spot.default_search_distance)
    end

  end

  def self.single_day_search(spots_array, start_time_filter, beginning_time_of_day, price_filter)
    spots_array.select do |spot|
      spot.available_listings.any? do |listing|
        if price_filter
          listing.is_available_on(start_time_filter) && listing.is_available_at_time_of_day(beginning_time_of_day) && listing.price <= price_filter.to_i
        else
          listing.is_available_on(start_time_filter) && listing.is_available_at_time_of_day(beginning_time_of_day)
        end
      end
    end
  end

  def self.multi_day_search(spots_array, start_time_filter, beginning_time_of_day, end_time_filter, ending_time_of_day, price_filter)
    spots_array.select do |spot|
      spot.available_listings.any? do |listing|
        if price_filter
          listing.is_available_between(start_time_filter, end_time_filter) && listing.price <= price_filter.to_i
        else
          listing.is_available_between(start_time_filter, end_time_filter)
        end
      end
    end
  end

  def self.spots_with_listings(spots_array)
    spots_array.select{|spot| spot.available_listings.size > 0}
  end

  def self.sort(spots_array, sort_type, current_location)
    if sort_type && sort_type == "Price"
      self.spots_with_listings(spots_array).sort{|a,b| a.lowest_price_listing.price <=> b.lowest_price_listing.price}
    elsif sort_type && sort_type == "Closest Time"
      self.spots_with_listings(spots_array).sort{|a,b| a.closest_time_listing.beginning_time <=> b.closest_time_listing.beginning_time}
    elsif sort_type && sort_type == "Closest Spot"
      self.spots_with_listings(spots_array).sort{|a,b| a.distance_from_location(current_location[0], current_location[1]) <=> b.distance_from_location(current_location[0], current_location[1])}
    end
  end


end
