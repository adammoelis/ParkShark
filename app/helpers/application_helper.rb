module ApplicationHelper
  def image_for_user(user, size = :thumb, css = nil, title = user.name)
    image_tag user.avatar.url(size), title: title, class: css
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

  def mailbox_new_message_count
    current_user.mailbox.receipts.where(is_read: false).count
  end
end
