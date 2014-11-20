class ControlsController < ApplicationController

	def index

		@controls= Control.order_by_date 


	end

	def event

		if request.xhr?
			@controls=Control.all 
			render json: @controls

		end

		# @controls= Control.all
		# @controls.to_json
		# render json: @controls

		
	end

	def evolution_control
		
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


	def edit
		@control= Control.find(params[:id])
	end


	def update

		@control= Control.find(params[:id])

		if @control.update_attributes(control_params)

			flash[:notice] = "Congratulation, your control has been updated"

			redirect_to controls_path
		else
			@errors= @control.errors.full_messages
			render 'edit'
		end
	end


	def destroy
		@control= Control.find(params[:id])

		if @control.delete

			flash[:notice] = "Congratulation, your control has been removed"

			redirect_to controls_path 
		end
	end



	private
	def control_params
		params.require(:control).permit(:level, :period, :day)
	end

end