class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :cars, :foreign_key => 'visitor_id'
  has_many :reviews, :foreign_key => 'visitor_id'
  has_many :reservations, :foreign_key => 'visitor_id'
  has_many :reservations, :foreign_key => 'owner_id'
  has_many :reviews, :foreign_key => 'owner_id', :through => 'spots'
  has_many :spots, :foreign_key => 'owner_id'
  has_many :listings, :foreign_key => 'owner_id', :through => 'spots'
  has_many :messages, :foreign_key => 'author_id'
  has_many :messages, :foreign_key => 'recipient_id'
  has_many :purchases, :foreign_key => 'visitor_id'
  has_many :purchases, :foreign_key => 'owner_id'
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable
  acts_as_messageable
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.jpg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  # used to create sub-merchant for owners selling parking spots
  # allows ability to send params over that are not stored in a database column
  attr_accessor :street_address, :city, :state, :zip_code, :account_number, :routing_number

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid, name: auth.info.name, avatar_file_name: auth.info.image, email: auth.extra.raw_info.email).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.avatar = URI.parse(auth.info.image) if auth.info.image?
      user.avatar_file_name = user.avatar_file_name.gsub("sz=50","sz=300") if auth.provider == "google_oauth2"
      user.email = auth.extra.raw_info.email if auth.extra.raw_info.email
      user.email = auth.info.email if auth.info.email
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def self.create_braintree_sub_merchant(params, current_user)
    split_name = current_user.name.split(" ")
    formatted_birthday = current_user.birthday.inspect.split(" ")
    phone = params[:user][:phone]
    phone.gsub!(/[^0-9A-Za-z]/, '')
    Braintree::MerchantAccount.create(
      :individual => {
        :first_name => Braintree::Test::MerchantAccount::Approve,
        :last_name => split_name[1],
        :email => current_user.email,
        :date_of_birth => "1981-11-19",
        :ssn => "456-45-4567",
        :address => {
          :street_address => params[:user][:street_address],
          :locality => params[:user][:city],
          :region => params[:user][:state],
          :postal_code => params[:user][:zip_code]
        }
      },
      :funding => {
        :destination => Braintree::MerchantAccount::FundingDestination::Bank,
        :email => current_user.email,
        :mobile_phone => phone,
        :account_number => params[:user][:account_number],
        :routing_number => params[:user][:routing_number]
      },
      :tos_accepted => true,
      :master_merchant_account_id => "student"
    )
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

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

  def set_location(latitude,longitude)
    self.latitude = latitude
    self.longitude = longitude
    self.save
  end
end
