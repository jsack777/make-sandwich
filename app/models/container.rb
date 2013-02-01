class Container < ActiveRecord::Base
  attr_accessible :name
  has_many :sandwich_containers
  has_many :sandwiches, :through => :sandwich_containers

  validates :name, :presence => true, :uniqueness => true
end
