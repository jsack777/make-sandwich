class MakeIngredientBaseClass < ActiveRecord::Migration
  def up
    add_column :ingredients, :type, :string
  end

  def down
    # non reversible
  end
end
