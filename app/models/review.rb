class Review < ActiveRecord::Base
  belongs_to :spot
  belongs_to :visitor, :class_name => 'User'
  has_one :owner, :class_name => 'User', :through => :spot

  def self.max_stars
    5
  end

  def blank_stars
    Review.max_stars - self.rating
  end
end
