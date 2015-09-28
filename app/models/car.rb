class Car < ActiveRecord::Base
  belongs_to :visitor, :class_name => 'User'
end
