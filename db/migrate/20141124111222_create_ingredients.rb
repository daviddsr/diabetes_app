class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :name
      t.string :ratio
      t.integer :meal_id

      t.timestamps
    end
  end
end
