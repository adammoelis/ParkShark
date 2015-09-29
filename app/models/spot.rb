class Spot < ActiveRecord::Base
  belongs_to :owner, :class_name => 'User'
  has_many :reviews
  geocoded_by :full_address
  after_validation :geocode, :if => :address_changed? 

  def full_address
    "#{self.address}, #{self.city}, #{self.state}, #{self.zip_code}"
  end
end
