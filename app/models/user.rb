class User < ActiveRecord::Base
  has_many :cars, :foreign_key => 'visitor_id'
  has_many :reviews, :foreign_key => 'visitor_id'
  has_many :spots, :foreign_key => 'owner_id'
  has_many :messages, :foreign_key => 'author_id'
  has_many :messages, :foreign_key => 'recipient_id'
  has_many :transactions, :foreign_key => 'visitor_id'
  has_many :transactions, :foreign_key => 'owner_id'
end
