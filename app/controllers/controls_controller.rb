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
		@user = User.find(params[:user_id])
	end

	def create
		@user = User.find(params[:user_id])
		@control= @user.controls.build(control_params)
		@control.save!
		flash[:notice] = "Congratulation, your control has been created"
		redirect_to user_controls_path(current_user)
	rescue ActiveRecord::RecordInvalid
		render 'new'
	end


	def edit
		@control = Control.find(params[:id])
		@user = User.find(params[:user_id])
	end


	def update
		@user = User.find(params[:user_id])
		@control = Control.find(params[:id])
		if @control.update_attributes(control_params)
			flash[:notice] = "Congratulation, your control has been updated"
			redirect_to user_controls_path(current_user)
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
			flash[:notice] = "Congratulation, your control has been removed"
			redirect_to user_controls_path(current_user)
		end
	end
	private
	def control_params
		params.require(:control).permit(:level, :period, :day)
	end
end
