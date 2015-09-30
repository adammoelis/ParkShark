class Spot < ActiveRecord::Base
  belongs_to :owner, :class_name => 'User'
  has_many :reviews
  geocoded_by :full_address
  after_validation :geocode, :if => :address_changed?
  has_attached_file :picture, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/

  def full_address
    "#{self.address}, #{self.city}, #{self.state}, #{self.zip_code}"
  end

  def address_without_street
    "#{self.city}, #{self.state}, #{self.zip_code}"
  end

  def class_type
    if self.available
      "available"
    else
      "reserved"
    end
  end
end
