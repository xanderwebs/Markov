class CreatePaths < ActiveRecord::Migration
  def change
    create_table :paths do |t|
      t.integer :total_traversals, default: 0

      t.timestamps
    end
    add_index :paths, :total_traversals
  end
end
