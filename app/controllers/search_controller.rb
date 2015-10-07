class SearchController < ApplicationController
  def nearby
    sort_type = params[:sort_type] if params[:sort_type]
    start_time_filter = parse_time_format(params['listing']['beginning_time']) if params[:listing]
    beginning_time_of_day_filter = params['listing']['beginning_time_of_day'] if params[:listing]
    if params['listing'] && params['listing']['ending_time'] != ""
      end_time_filter = parse_time_format(params['listing']['ending_time'])
      ending_time_of_day_filter = params['listing']['ending_time_of_day']
    elsif start_time_filter
      end_time_filter = start_time_filter
    end
    price_filter = params[:price] if params[:price] && params[:price].size > 0
    if current_location
      @spots = Search.search_near(params[:q], params[:radius], current_location)
    else
      flash[:notice] = "Please enable location finding in your browser to see nearby spots"
      @spots = Spot.all
    end
    @spots = Search.for(@spots, start_time_filter, end_time_filter, price_filter, beginning_time_of_day_filter, ending_time_of_day_filter)
    @spots = Search.sort(@spots, sort_type, current_location) if sort_type
  end

  private

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


end
