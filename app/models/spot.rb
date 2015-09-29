class Spot < ActiveRecord::Base
  belongs_to :owner, :class_name => 'User'
  has_many :reviews
  geocoded_by :address
  after_validation :geocode
end
