class HomeController < ApplicationController
  def index
    if current_location
      @spots = Search.search_near(current_location, 10, nil)
      if @spots.size >= 2
        @top_2_spots = @spots.first(2)
      else
        @top_2_spots = Spot.last(2)
      end
      if @spots.size < 10
        @last_8_spots = Spot.last(8)
      else
        @last_8_spots = @spots.last(10)
      end
    else
      @spots = Spot.last(10)
    end
  end

  def about
  end

  def contact
  end

  def resource_name
   :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def my_location

  end

  def set_location
    if current_user
      current_user.set_location(params[:latitude], params[:longitude])
    else
      session[:latitude] = params[:latitude]
      session[:longitude] = params[:longitude]
    end

  end
end
