class Reservation < ActiveRecord::Base
  belongs_to :visitor, :class_name => 'User'
  belongs_to :owner, :class_name => 'User'
  belongs_to :spot
  belongs_to :listing
end
