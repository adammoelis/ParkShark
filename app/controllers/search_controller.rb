class SearchController < ApplicationController
  before_action :check_current_location, only: [:available_now, :available_now_query]
  before_action :establish_variables, only: [:nearby]

  def nearby
    if current_location
      @spots = Search.search_near(params[:q], params[:radius], current_location)
    else
      flash[:notice] = "Please enable location finding in your browser to see nearby spots"
      @spots = Spot.all
    end
    if @spots.length == 0
      flash[:error] = "Sorry, there are no spots that meet your requested criteria."
    else
      @listings = Search.for(@spots, @start_time_filter, @end_time_filter, @price_filter, @beginning_time_of_day_filter, @ending_time_of_day_filter).paginate(:page => params[:page], :per_page => 15)
      @listings = Search.sort(@listings, @sort_type, current_location).paginate(:page => params[:page], :per_page => 15) if @sort_type
    end
    set_maps_hash
  end

  def available_now
    @listings = @spots.map {|spot| spot.available_listings_now}.flatten.sort_by {|listing| listing.price}.paginate(:page => params[:page], :per_page => 15)
    get_unique_spots
    flash[:notice] = "There appear to be no available spots near you at the moment" if @listings.empty?
    set_maps_hash
    render 'available_now'
  end

  def available_now_query
    @listings = @spots.map {|spot| spot.available_listings_at(params[:time_of_day])}.flatten.sort_by {|listing| listing.price}.paginate(:page => params[:page], :per_page => 15)
    get_unique_spots
    set_maps_hash
  end

  def create_map

  end

  private

  def get_unique_spots
    @spots = @listings.map {|listing| listing.spot}.uniq
  end

  def set_maps_hash
    @hash = Gmaps4rails.build_markers(@listings) do |listing, marker|
      marker.lat listing.spot.latitude
      marker.lng listing.spot.longitude
      marker.picture({
       "width" =>  32,
       "height" => 32})
      marker.json({:listingId => listing.id, :spotId => listing.spot.id })
      marker.infowindow "$#{listing.price.round(0)}"
    end
  end

  # def set_maps_hash_for_spots
  #   @hash = Gmaps4rails.build_markers(@spots) do |spot, marker|
  #     marker.lat spot.latitude
  #     marker.lng spot.longitude
  #     marker.picture({
  #      "width" =>  32,
  #      "height" => 32})
  #     marker.json({:spotId => spot.id })
  #     marker.infowindow "#{spot.description}"
  #   end
  # end

  def establish_variables
    @sort_type = params[:sort_type] if params[:sort_type]
    @start_time_filter = parse_time_format(params['listing']['beginning_time']) if params[:listing]
    @beginning_time_of_day_filter = params['listing']['beginning_time_of_day'] if params[:listing]
    if params['listing'] && params['listing']['ending_time'] != "" && params['listing']['ending_time']
      @end_time_filter = parse_time_format(params['listing']['ending_time'])
      @ending_time_of_day_filter = params['listing']['ending_time_of_day']
    elsif @start_time_filter
      @end_time_filter = @start_time_filter
    end
    @price_filter = params[:price] if params[:price] && params[:price].size > 0
  end

  def check_current_location
    if current_location
      @spots = Search.search_near(params[:q], params[:radius], current_location)
    else
      @spots = []
      flash[:error] = "Please enable location access in your browser"
    end
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


end
