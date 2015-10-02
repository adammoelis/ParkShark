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
    if self.any_available?
      "available"
    else
      "reserved"
    end
  end
end
