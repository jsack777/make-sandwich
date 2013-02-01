class CreateContainers < ActiveRecord::Migration
  def change
    create_table :containers do |t|
      t.string :name
      t.integer :sandwich_id

      t.timestamps
    end

    add_index :containers, :sandwich_id
  end
end
