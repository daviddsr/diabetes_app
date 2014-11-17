class CreateMonths < ActiveRecord::Migration
  def change
    create_table :months do |t|
      t.string :name	
      t.date :day
      t.string :period
      t.integer :user_id
      t.integer :control

      t.timestamps
    end
  end
end
