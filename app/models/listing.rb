class Listing < ActiveRecord::Base
  validates_presence_of :beginning_time, :ending_time, :price
  belongs_to :spot
  has_one :owner, :class_name => 'User', :through => :spot
  has_one :reservation

  MORNING = "Morning (7am-11am)"
  AFTERNOON = "Afternoon (11am- 2pm)"
  LATE_AFTERNOON = "Late Afternoon (2pm-5pm)"
  EARLY_EVENING = "Early Evening (5pm-8pm)"
  EVENING = "Evening (8pm-11pm)"
  LATE_NIGHT = "Late Night (11pm-4am)"
  EARLY_MORNING = "Early Morning (4am-7am)"

  def self.time_of_day_options
    [MORNING, AFTERNOON, LATE_AFTERNOON, EARLY_EVENING, EVENING, LATE_NIGHT, EARLY_MORNING]
  end

  def status
    self.available ? "Available" : "Occupied"
  end

  def is_available_between(start_time, end_time)
    if self.ending_time <= end_time && self.beginning_time <= start_time
      true
    else
      false
    end
  end
end
