class ControlsController < ApplicationController

	before_action :authenticate_user!

	def index

		

		@user= current_user
		@control= Control.new


		@control_last = Control.lastcontrol (current_user.id)


		

		@controls_average = Control.controls_average (current_user.id)

		@controls_average_day = Control.controls_day_average (current_user.id)
		
	end

	def event
		@user= current_user
		@controls=@user.controls.all
		render json: @controls if request.xhr?
	end

	def months
		@user= current_user

		@controls_ordered = Control.order_by_date(current_user.id)

		@control_last = Control.lastcontrol (current_user.id)


		

		@controls_average = Control.controls_average (current_user.id)

		@controls_average_day = Control.controls_day_average (current_user.id)
		
 
	end

	
	

	def new
		
	end

	def create
		@user = current_user
		control_params2 ={}
		control_params2[:level] = control_params[:level]
		control_params2[:period] = control_params[:period]
		control_params2[:day]=DateTime.strptime(control_params[:day],'%m/%d/%Y %I:%M %p')
		@control= @user.controls.build(control_params2)
		@control.save!
		flash[:notice] = "Congratulations, your control has been created"
		redirect_to controls_path
	rescue ActiveRecord::RecordInvalid
		flash[:error]
		render 'index'
	end


	def edit
		# if request.xhr?
			@control = Control.find(params[:id])
		# end
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
