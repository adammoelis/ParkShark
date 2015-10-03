module ApplicationHelper
  def image_for(user, size = :thumb, title = user.name)
    if user.avatar.exists?
      image_tag user.avatar.url(size), title: title, class: 'img-rounded'
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

  def render_page_template(title, partial = 'form')
    page = <<-HTML
    <main>
      <section>
        <div class="container inner-top-sm inner-bottom-sm">
          <div class="row">
            <div class="col-md-6 col-sm-9 center-block">
              <header>
                <h1>#{title}</h1>
              </header>
              #{render partial}
           </div><!-- /.col -->
         </div><!-- /.row -->
       </div>
     </section>
    </main>
    HTML
    page.html_safe
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

end
