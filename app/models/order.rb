class Order < ActiveRecord::Base
  attr_accessible :user_id

  belongs_to :user
  has_many :sandwiches

  validates :user_id, :presence => true
end
