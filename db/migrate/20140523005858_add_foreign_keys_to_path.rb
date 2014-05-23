class AddForeignKeysToPath < ActiveRecord::Migration
  def change
    add_column :paths, :begin_node_id, :integer
    add_column :paths, :end_node_id, :integer
    remove_index :paths, :total_traversals
    add_index :paths, :end_node_id
    add_index :paths, :begin_node_id
  end
end
