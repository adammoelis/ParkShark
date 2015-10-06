module ApplicationHelper
  def image_for_user(user, size = :thumb, css = "", title = user.name)
    if user.avatar_content_type
      image_tag user.avatar.url(size), title: title, class: css
    else
      if size == :thumb
        image_tag user.avatar_file_name, title: title, class: css + " thumb-img"
      else
        image_tag user.avatar_file_name, title: title, class: css + " medium-img"
      end
    end
  end

  def image_for_spot(spot, size = :thumb, css = nil, title = spot.title)
    if !spot.pictures.empty?
      image_tag spot.pictures.first.picture.url(size), title: title, class: css
    else
      image_tag '/images/medium/nophotos.jpg', title: title, class: css
    end
  end

  def image_url_for(user, title = user.name)
    if user.avatar
      user.avatar.url(:thumb)
    else
      user.avatar_file_name
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
end
