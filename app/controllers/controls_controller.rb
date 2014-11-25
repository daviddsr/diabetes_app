class ControlsController < ApplicationController

	before_action :authenticate_user!

	def index

		

		@user= current_user

		@controls= @user.controls.order_by_date
		# @controls = Control.order_by_date
	end

	def event
		@user= current_user
		@controls=@user.controls.all
		render json: @controls if request.xhr?
	end

	def show
	end

	def new
		@control= Control.new
		@user = current_user
	end

	def create
		@user = current_user
		@control= @user.controls.build(control_params)
		@control.save!
		flash[:notice] = "Congratulations, your control has been created"
		redirect_to controls_path
	rescue ActiveRecord::RecordInvalid
		render 'new'
	end


	def edit
		@control = Control.find(params[:id])
		
	end


	def update
		@user = current_user
		@control = Control.find(params[:id])
		if @control.update_attributes(control_params)
			flash[:notice] = "Congratulations, your control has been updated"
			redirect_to controls_path(current_user)
		else
			@errors = @control.errors.full_messages
			render 'edit'
		end
	end

	def delete
		@control= Control.find(params[:id])

	end

	def destroy
		@control= Control.find(params[:id])
		if @control.delete
			flash[:notice] = "Congratulations, your control has been removed"
			redirect_to controls_path
		end
	end
	private
	def control_params
		params.require(:control).permit(:level, :period, :day)
	end
end
