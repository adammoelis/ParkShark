class Search < ActiveRecord::Base
  def self.for(spots_array, start_time, end_time, price_filter, beginning_time_of_day_filter, ending_time_of_day_filter)
    if !start_time
      spots = spots_array
    elsif start_time == end_time
      spots =self.single_day_search(spots_array, start_time, beginning_time_of_day_filter, price_filter)
    else
      spots = self.multi_day_search(spots_array, start_time, beginning_time_of_day_filter, end_time, ending_time_of_day_filter, price_filter)
    end
  end

  def self.single_day_search(spots_array, start_time_filter, beginning_time_of_day, price_filter)
    spots_array.select do |spot|
      spot.available_listings.any? do |listing|
        if price_filter == ""
          listing.is_available_on(start_time_filter) && listing.is_available_at_time_of_day(beginning_time_of_day)
        else
          listing.is_available_on(start_time_filter) && listing.is_available_at_time_of_day(beginning_time_of_day) && listing.price <= price_filter.to_i
        end
      end
    end
  end

  def self.multi_day_search(spots_array, start_time_filter, beginning_time_of_day, end_time_filter, ending_time_of_day, price_filter)
    spots_array.select do |spot|
      spot.available_listings.any? do |listing|
        if price_filter == ""
          listing.is_available_between(start_time_filter, end_time_filter)
        else
          listing.is_available_between(start_time_filter, end_time_filter) && listing.price <= price_filter.to_i
        end
      end
    end
  end


end
