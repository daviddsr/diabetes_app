class MealsController < ApplicationController

	def index
		@meals= Meal.all
	end

	def new
		@meal= Meal.new
		@ingredients= Ingredient.all
	end

	def create
		@meal= Meal.create(meal_params)
		@meal.save!
		flash[:notice] = "Congratulation, your meal has been created"
		redirect_to meals_path
	rescue ActiveRecord::RecordInvalid
		render 'new'
	end

	private
	def meal_params
		params.require(:meal).permit(:ingredient, :grams, :day)
	end

end
