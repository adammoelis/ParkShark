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

  MORNING_TIME_RANGE = [7, 8, 9, 10]
  AFTERNOON_TIME_RANGE = [11, 12, 13]
  LATE_AFTERNOON_TIME_RANGE = [14, 15, 16]
  EARLY_EVENING_TIME_RANGE = [17, 18, 19]
  EVENING_TIME_RANGE = [20, 21, 22]
  LATE_NIGHT_TIME_RANGE = [23, 0, 1, 2, 3]
  EARLY_MORNING_TIME_RANGE = [4, 5, 6, 7]

  def self.time_of_day_options
    [MORNING, AFTERNOON, LATE_AFTERNOON, EARLY_EVENING, EVENING, LATE_NIGHT, EARLY_MORNING]
  end

  def self.max_price(listings_array)
    if listings_array.empty?
      Listing.all.sort_by(&:price).last.price
    else
      listings_array.sort_by(&:price).last.price
    end
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
    if self.beginning_time.to_date == start_time.to_date
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
    self.beginning_time_of_day == Listing.current_time_of_day
  end

  def self.current_time_of_day
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

  def self.ending_time_of_day_array(time_of_day)
    case time_of_day
    when MORNING
      1
    when AFTERNOON
      2
    when LATE_AFTERNOON
      3
    when EARLY_EVENING
      4
    when EVENING
      5
    when LATE_NIGHT
      6
    when EARLY_MORNING
      7
    end
  end

  def expired?
    current_hour = DateTime.now.hour
    if DateTime.now.to_date > self.ending_time.to_date
      true
    elsif DateTime.now.to_date < self.ending_time.to_date
      false
    else
      Listing.ending_time_of_day_array(self.ending_time_of_day) < Listing.ending_time_of_day_array(Listing.current_time_of_day)
    end
  end

  def available_at(time_of_day)
    self.ending_time_of_day == time_of_day
  end

  def multi_day?
    self.beginning_time != self.ending_time
  end

  def single_day?
    self.beginning_time == self.ending_time
  end

end
