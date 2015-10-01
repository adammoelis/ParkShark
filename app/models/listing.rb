class Listing < ActiveRecord::Base
  belongs_to :spot
  has_one :owner, :class_name => 'User', :through => :spot
end
