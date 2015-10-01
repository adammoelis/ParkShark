module ApplicationHelper
  def image_for(user, title = user.name)
    if user.avatar.exists?
      image_tag user.avatar.url(:thumb), title: title, class: 'img-rounded'
    else
      image_tag user.avatar_file_name, title: title, class: 'img-rounded'
    end
  end

  def image_url_for(user, title = user.name)
    if user.avatar.exists?
      user.avatar.url(:thumb)
    else
      user.avatar_file_name
    end
  end
end
