class AddIngredientsSandwiches < ActiveRecord::Migration
  def up
    create_table :sandwich_ingredients, :id => false do |t|
      t.integer :ingredient_id
      t.integer :sandwich_id
    end

    add_index :sandwich_ingredients, [:ingredient_id, :sandwich_id]
    add_index :sandwich_ingredients, [:sandwich_id, :ingredient_id]
  end

  def down
    remove_index :sandwich_ingredients, [:ingredient_id, :sandwich_id]
    remove_index :sandwich_ingredients, [:sandwich_id, :ingredient_id]

    drop_table :sandwich_ingredients
  end
end
