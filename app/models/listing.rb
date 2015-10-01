class Listing < ActiveRecord::Base
  validates_presence_of :beginning_time, :ending_time, :price
  belongs_to :spot
  has_one :owner, :class_name => 'User', :through => :spot

  def status
    self.available ? "Available" : "Occupied"
  end
end
