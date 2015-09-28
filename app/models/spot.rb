class Spot < ActiveRecord::Base
  belongs_to :owner, :class_name => 'User'
  has_many :reviews
end
