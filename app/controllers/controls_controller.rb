class ControlsController < ApplicationController

	def index

		@controls= Control.order_by_date


	end

	def show
	end

	def new

		@control= Control.new
	end

	def create
		@control= Control.new(control_params)

		if @control.save
			flash[:notice] = "Congratulation, your control has been created"

			redirect_to controls_path
		else
			render 'new'

		end
	end

	def destroy
		@control= Control.find(params[:id])

		if @control.delete

			redirect_to controls_path 
		end
	end


	private
	def control_params
		params.require(:control).permit(:level, :period, :day)
	end

end