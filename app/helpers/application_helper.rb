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
end
