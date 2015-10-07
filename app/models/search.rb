class Search < ActiveRecord::Base
  def self.for(spots_array, start_time, end_time, price_filter, beginning_time_of_day_filter, ending_time_of_day_filter)
    if !start_time
      spots_array
    elsif start_time == end_time
      binding.pry
      self.single_day_search(spots_array, start_time, beginning_time_of_day_filter)
    else

    end
  end

  def self.single_day_search(spots_array, start_time_filter, beginning_time_of_day)
    spots_array.select do |spot|
      spot.available_listings.any? do |listing|
        listing.is_available_on(start_time_filter) && listing.is_available_at_time_of_day(beginning_time_of_day)
      end
    end
  end
end
