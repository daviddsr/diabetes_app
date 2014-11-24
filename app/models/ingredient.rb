class Ingredient < ActiveRecord::Base

	belongs_to :meal
	


def self.showAll
ingredientsArray = []
		Ingredient.all.each do |ingredient|
			ingredientsArray.push(ingredient.name)

end
return ingredientsArray
end

end
