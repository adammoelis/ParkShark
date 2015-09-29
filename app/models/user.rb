class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :cars, :foreign_key => 'visitor_id'
  has_many :reviews, :foreign_key => 'visitor_id'
  has_many :spots, :foreign_key => 'owner_id'
  has_many :messages, :foreign_key => 'author_id'
  has_many :messages, :foreign_key => 'recipient_id'
  has_many :transactions, :foreign_key => 'visitor_id'
  has_many :transactions, :foreign_key => 'owner_id'
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.jpg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
end
