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

  MORNING_TIME_RANGE = [7, 8, 9, 10, 11]
  AFTERNOON_TIME_RANGE = [11, 12, 13, 14]
  LATE_AFTERNOON_TIME_RANGE = [14, 15, 16, 17]
  EARLY_EVENING_TIME_RANGE = [17, 18, 19, 20]
  EVENING_TIME_RANGE = [20, 21, 22, 23]
  LATE_NIGHT_TIME_RANGE = [23, 24, 1, 2, 3, 4]
  EARLY_MORNING_TIME_RANGE = [4, 5, 6, 7]

  def self.time_of_day_options
    [MORNING, AFTERNOON, LATE_AFTERNOON, EARLY_EVENING, EVENING, LATE_NIGHT, EARLY_MORNING]
  end

  def status
    self.available ? "Available" : "Occupied"
  end

  def is_available_between(start_time, end_time)
    if end_time == start_time
      self.beginning_time == start_time
    elsif self.ending_time >= end_time && self.beginning_time <= start_time
      true
    else
      false
    end
  end

  def is_available_on(start_time)
    if self.beginning_time == start_time
      true
    else
      false
    end
  end

  def is_available_at_time_of_day(time_of_day)
    if self.beginning_time_of_day == time_of_day
      true
    else
      false
    end
  end

  def available_now?
    self.available_today? && self.available_at_current_time_of_day?
  end

  def available_today?
    beginning_time.to_date == DateTime.now.to_date
  end

  def available_at_current_time_of_day?
    self.beginning_time_of_day == self.current_time_of_day
  end

  def current_time_of_day
    current_hour = DateTime.now.hour
    if MORNING_TIME_RANGE.include?(current_hour)
      MORNING
    elsif AFTERNOON_TIME_RANGE.include?(current_hour)
      AFTERNOON
    elsif LATE_AFTERNOON_TIME_RANGE.include?(current_hour)
      LATE_AFTERNOON
    elsif EARLY_EVENING_TIME_RANGE.include?(current_hour)
      EARLY_EVENING
    elsif EVENING_TIME_RANGE.include?(current_hour)
      EVENING
    elsif LATE_NIGHT_TIME_RANGE.include?(current_hour)
      LATE_NIGHT
    elsif EARLY_MORNING_TIME_RANGE.include?(current_hour)
      EARLY_MORNING
    end
  end

end
