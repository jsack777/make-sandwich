class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :password, :user_name
  has_many :orders
end
