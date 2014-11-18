class CreateControls < ActiveRecord::Migration
  def change
    create_table :controls do |t|
      t.integer :level
      t.string :period
      t.datetime :day
      
      t.timestamps
    end
  end
end
