module ApplicationHelper
  def image_for_user(user, size = :medium, css = nil, title = user.name)
    image_tag user.avatar.url(size), title: title, class: css
  end

  def image_for_spot(spot, size = :medium, css = nil, title = spot.title)
    if spot.pictures.empty?
      image_tag '/images/medium/nophotos.jpg', title: title, class: css
    else
      image_tag spot.pictures.first.picture.url(size), title: title, class: css
    end
  end

  def distance_between(object1, object2)
    Geocoder::Calculations.distance_between([object1.latitude, object1.longitude], [object2.latitude, object2.longitude])
  end

  def distance_between_me_and(object)
    Geocoder::Calculations.distance_between([session[:latitude], session[:longitude]], [object.latitude, object.longitude])
  end

  def current_location
    if current_user
      [current_user.latitude, current_user.longitude]
    else
      [session[:latitude], session[:longitude]]
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

  def mailbox_new_message_count
    current_user.mailbox.receipts.where(is_read: false).count
  end

  def ending_time_of_day_array(time_of_day)
    case time_of_day
    when MORNING
      MORNING_TIME_RANGE
    when AFTERNOON
      AFTERNOON_TIME_RANGE
    when LATE_AFTERNOON
      LATE_AFTERNOON_TIME_RANGE
    when EARLY_EVENING
      EARLY_EVENING_TIME_RANGE
    when EVENING
      EVENING_TIME_RANGE
    when LATE_NIGHT
      LATE_NIGHT_TIME_RANGE
    when EARLY_MORNING
      EARLY_MORNING_TIME_RANGE
    end
  end

  def max_price_listing_in(spots_array)
    listings = spots_array.sort{|a,b| a.lowest_price_listing.price <=> b.lowest_price_listing.price}.last.listings
    listings.sort_by(&:price).last.price
  end


end
