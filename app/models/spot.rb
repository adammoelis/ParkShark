class Spot < ActiveRecord::Base
  belongs_to :owner, :class_name => 'User'
  has_many :reviews, :dependent => :destroy
  has_many :listings, :dependent => :destroy
  has_many :pictures, :dependent => :destroy
  has_many :purchases
  has_many :reservations, :dependent => :destroy
  validates_presence_of :title, :address, :city, :state, :zip_code
  geocoded_by :full_address
  after_validation :geocode, :if => :address_changed?

  def self.default_search_distance
    10
  end

  def self.types_of_spots
    ["Garage", "Driveway", "Street", "Lot"]
  end

  def self.all_spots_with_currently_available_listings
    Spot.select {|spot| spot.has_an_available_listing_right_now}
  end

  def self.spots_with_currently_available_listings(spots_array)
    spots_array.select {|spot| spot.has_an_available_listing_right_now}
  end

  def full_address
    "#{self.address}, #{self.city}, #{self.state}, #{self.zip_code}"
  end

  def address_without_street
    "#{self.city}, #{self.state}, #{self.zip_code}"
  end

  def any_available?
    self.listings.any?{|listing| listing.available}
  end

  def class_type
    self.type_of_spot
  end

  def lowest_price_listing
    available_listings.min_by{|listing| listing.price}
  end

  def highest_price_listing
    available_listings.max_by{|listing| listing.price}
  end

  def closest_time_listing
    available_listings.min_by{|listing| listing.beginning_time}
  end

  def distance_from_user(user_object)
    Geocoder::Calculations.distance_between([self.latitude, self.longitude], [user_object.latitude, user_object.longitude])
  end

  def distance_from_location(latitude, longitude)
    Geocoder::Calculations.distance_between([self.latitude, self.longitude], [latitude, longitude])
  end

  def show_price_range
    if highest_price_listing && lowest_price_listing && highest_price_listing != lowest_price_listing
      "$#{self.lowest_price_listing.price.round(0)} - $#{self.highest_price_listing.price.round(0)}"
    elsif highest_price_listing == lowest_price_listing && highest_price_listing
      "$#{highest_price_listing.price.round(0)}"
    else

    end
  end

  def available_listings
    self.listings.where(available: true)
  end

  def has_an_available_listing_right_now
    listings.any?{|listing| listing.available_now?}
  end

  def available_listings_now
    listings.select{|listing| listing.available_now?}
  end

  def map_html(width, height, zoom)
    "<iframe id='map' width='#{width}' height='#{height}' class='center-block' frameborder='0' style='border:0' src='https://www.google.com/maps/embed/v1/view?key=#{ENV['GOOGLE_KEY']}&center=#{self.latitude},#{self.longitude}&zoom=#{zoom}&maptype=roadmap' allowfullscreen></iframe>".html_safe
  end

end
