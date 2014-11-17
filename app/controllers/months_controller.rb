class MonthsController < ApplicationController

	def index
		@months= Month.all
	end

	def show
		@month = Month.find(params[:id])

	end
end
