class Sandwich < ActiveRecord::Base
  attr_accessible :containers, :ingredients, :order_id

  has_many :sandwich_containers
  has_many :containers, :through => :sandwich_containers
  has_many :sandwich_ingredients
  has_many :ingredients, :through => :sandwich_ingredients
  belongs_to :order

  validate :length_of_containers
  validates :order_id, :presence => true

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

  def self.update_one(options = {})
    sandwich = find options[:id]
    sandwich.container = Container.find(options[:container]) if options[:container].present?
    sandwich.ingredients = [Ingredient.find(options[:ingredients])].flatten if options[:ingredients].present?
    sandwich
  end

  def self.build_one(options = {})
    sandwich = new
    sandwich.order_id = options[:order_id] if options[:order_id].present?
    sandwich.container = Container.find(options[:container]) if options[:container].present?
    sandwich.ingredients = [Ingredient.find(options[:ingredients])].flatten if options[:ingredients].present?
    sandwich
  end

  def self.copy(id)
    sandwich = find(id)
    new_sandwich = new
    new_sandwich.theme = sandwich.theme
    new_sandwich.container = sandwich.container
    new_sandwich.ingredients = sandwich.ingredients
    new_sandwich
  end

  # 3 types of sandwiches as starting points
  def self.meaty
    sandwich = new
    sandwich.theme = "Meaty"
    sandwich.container = Container.last
    sandwich.ingredients = [
        Meat.meaty, Cheese.first
    ].flatten
    sandwich
  end

  def self.veggie
    sandwich = new
    sandwich.theme = "Veggie"
    sandwich.container = Container.last
    sandwich.ingredients = [
        Meat.veggie, Cheese.last, Vegetable.all
    ].flatten
    sandwich
  end

  def self.vegan
    sandwich = new
    sandwich.theme = "Vegan"
    sandwich.container = Container.first
    sandwich.ingredients = [
        Vegetable.all
    ].flatten
    sandwich
  end

  def self.examples
    ["Meaty", "Veggie", "Vegan"]
  end

  def self.themed(options = {})
    logger.debug "themed options: #{options.inspect}"
    sandwich =
        case options[:theme]
          when 'Meaty'
            meaty
          when 'Veggie'
            veggie
          when 'Vegan'
            vegan
          else
            new
        end
    sandwich.order_id = options[:order_id]
    sandwich
  end

end
