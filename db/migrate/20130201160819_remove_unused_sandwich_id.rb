class RemoveUnusedSandwichId < ActiveRecord::Migration
  def up
    remove_index :containers, :sandwich_id
    remove_column :containers, :sandwich_id
    remove_index :ingredients, :sandwich_id
    remove_column :ingredients, :sandwich_id
  end

  def down
    add_column :containers, :sandwich_id
    add_index :containers, :sandwich_id
    add_column :ingredients, :sandwich_id
    add_index :ingredients, :sandwich_id
  end
end
