class AddSandwichTheme < ActiveRecord::Migration
  def up
    add_column :sandwiches, :theme, :string
  end

  def down
    remove_column :sandwiches, :theme, :string
  end
end
