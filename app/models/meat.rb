class Meat < Ingredient
  extend IngredientName

  scope :veggie, where("name like '%veggie%'")
  scope :meaty, where("name not like '%veggie%'")
end