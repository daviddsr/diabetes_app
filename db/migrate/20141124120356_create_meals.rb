class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.string :grams
      t.string :user_id
      t.string :ingredient_id

      t.timestamps
    end
  end
end
