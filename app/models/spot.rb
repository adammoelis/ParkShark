class Spot < ActiveRecord::Base
  belongs_to :owner, :class_name => 'User'
  has_many :reviews
  has_many :pictures, :dependent => :destroy
  has_many :purchases
  geocoded_by :full_address
  after_validation :geocode, :if => :address_changed?

  def full_address
    "#{self.address}, #{self.city}, #{self.state}, #{self.zip_code}"
  end

  def address_without_street
    "#{self.city}, #{self.state}, #{self.zip_code}"
  end

  def class_type
    if self.available
      "available"
    else
      "reserved"
    end
  end
end
