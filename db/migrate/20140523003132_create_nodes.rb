class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :name
      t.integer :total_visits, default: 0

      t.timestamps
    end
  end
end
