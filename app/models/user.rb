class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :cars, :foreign_key => 'visitor_id'
  has_many :reviews, :foreign_key => 'visitor_id'
  has_many :reviews, :foreign_key => 'owner_id', :through => 'spots'
  has_many :spots, :foreign_key => 'owner_id'
  has_many :listings, :foreign_key => 'owner_id', :through => 'spots'
  has_many :messages, :foreign_key => 'author_id'
  has_many :messages, :foreign_key => 'recipient_id'
  has_many :transactions, :foreign_key => 'visitor_id'
  has_many :transactions, :foreign_key => 'owner_id'
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  acts_as_messageable
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.jpg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/


  def age(birthday)
    now = Time.now.utc.to_date
    if birthday
      now.year - birthday.year - ((now.month > birthday.month || (now.month == birthday.month && now.day >= birthday.day)) ? 0 : 1)
    else
      birthday
    end
  end

  def mailboxer_email(object)
    email
  end
end
