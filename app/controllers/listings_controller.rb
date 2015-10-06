class ListingsController < ApplicationController
  before_action :find_spot, only: [:create, :new, :destroy]
  before_action :find_listing, only: [:destroy]

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(beginning_time: parse_time_format(params['listing']['beginning_time']), price: params[:listing][:price], spot: @spot, available: true)
    if params['listing']['ending_time'] != ""
      @listing.ending_time = parse_time_format(params['listing']['ending_time'])
    else
      @listing.ending_time = parse_time_format(params['listing']['beginning_time'])
    end
    binding.pry
    if @listing.save
      redirect_to spot_path(@spot)
    else
      render 'new'
    end
  end

  def destroy
    @listing.destroy
  end

  private

  def parse_time_format(time)
    array_of_time = time.split("/")
    month = array_of_time[0]
    day = array_of_time[1]
    year = array_of_time[2]
    DateTime.parse("#{year}/#{month}/#{day}")
  end

  def find_spot
    @spot = Spot.find(params[:spot_id])
  end

  def find_listing
    @listing = Listing.find(params[:id])
  end
end
