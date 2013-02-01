class Sandwich < ActiveRecord::Base
  attr_accessible :containers, :ingredients

  has_many :sandwich_containers
  has_many :containers, :through => :sandwich_containers
  has_many :sandwich_ingredients
  has_many :ingredients, :through => :sandwich_ingredients
  belongs_to :order

  validate :length_of_containers

  def length_of_containers
    if self.containers.length != 1
      errors.add(:containers, "must be 1 and only 1 container for a sandwich")
    end
  end

  before_save :assure_unique_ingredients

  # sorry - no double cheese :)
  def assure_unique_ingredients
    self.ingredients.uniq!
  end

  def container
    containers.first
  end

  def container=(value)
    containers.pop
    containers << value
  end

  # 3 types of sandwiches as starting points
  def self.meaty
    sandwich = new
    sandwich.container = Container.first
    sandwich.ingredients = [
        Meat.meaty, Cheese.first
    ].flatten
    sandwich
  end

  def self.veggie
    sandwich = new
    sandwich.container = Container.last
    sandwich.ingredients = [
        Meat.veggie, Cheese.last, Vegetable.all
    ].flatten
    sandwich
  end

  def self.vegan
    sandwich = new
    sandwich.container = Container.last
    sandwich.ingredients = [
        Vegetable.all
    ].flatten
    sandwich
  end

end
