class Ingredient < ActiveRecord::Base
  TYPES = %w(Cheese Condiment Meat Vegetable)

  attr_accessible :name, :type
  has_many :sandwich_ingredients
  has_many :sandwiches, :through => :sandwich_ingredients

  validates :name, :presence => true, :uniqueness => true
end
