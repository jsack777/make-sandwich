class CreateSandwiches < ActiveRecord::Migration
  def change
    create_table :sandwiches do |t|
      t.integer :order_id
      t.timestamps
    end

    add_index :sandwiches, :order_id
  end
end
