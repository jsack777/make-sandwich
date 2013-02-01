class AddContainersSandwiches < ActiveRecord::Migration
  def up
    create_table :sandwich_containers, :id => false do |t|
      t.integer :container_id
      t.integer :sandwich_id
    end

    add_index :sandwich_containers, [:container_id, :sandwich_id]
    add_index :sandwich_containers, [:sandwich_id, :container_id]
  end

  def down
    remove_index :sandwich_containers, [:container_id, :sandwich_id]
    remove_index :sandwich_containers, [:sandwich_id, :container_id]

    drop_table :sandwich_containers
  end
end
