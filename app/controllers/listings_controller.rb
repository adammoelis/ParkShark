class ListingsController < ApplicationController
  before_action :find_spot, only: [:create, :new]

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new
    @listing.beginning_time = parse_time('beginning_time')
    @listing.ending_time = parse_time('ending_time')
    @listing.price = params[:listing][:price]
    @listing.spot = @spot
    @listing.available = true
    if @listing.save
      redirect_to spot_path(@spot)
    else
      render 'new'
    end
  end

  def update
    @spot = Spot.find(params[:spot_id])
    @listing = Listing.find(params[:id])
    @listing.available = false
    @listing.save
    @reservation = Reservation.new(owner: @spot.owner, visitor: current_user, spot: @spot, listing: @listing)
    @reservation.save
    redirect_to spot_path(@spot)
  end

  private

  def parse_time(type_of_time)
    year = params["listing"]["#{type_of_time}(1i)"]
    month = params["listing"]["#{type_of_time}(2i)"]
    day = params["listing"]["#{type_of_time}(3i)"]
    hour = params["listing"]["#{type_of_time}(4i)"]
    minute = params["listing"]["#{type_of_time}(5i)"]
    DateTime.parse("#{year}/#{month}/#{day} #{hour}:#{minute}")
  end

  def find_spot
    @spot = Spot.find(params[:spot_id])
  end
end
