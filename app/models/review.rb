class Review < ActiveRecord::Base
  belongs_to :spot
  belongs_to :visitor, :class_name => 'User'
  has_one :owner, :class_name => 'User', :through => :spot
end
