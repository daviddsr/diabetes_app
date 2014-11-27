class GraphicsController < ApplicationController


before_action :authenticate_user!

	def index

		

		@user= current_user
		@controls= @user.controls

	end

	def graphics_evolution

		@user= current_user
		@controls= @user.controls
		
     # graphic_data = Control.graphic_data_for_a_day "2014-11-21"
    
    	# puts graphic_data
    dates= @controls.all.map { |control| control.day.strftime("%d-%m-%Y") }
		
		

    days = []

    dates.each do |date|
    	unless days.include?(date)
    		days.push(date)
    	end

    end


    graphic_data=[]

    days.each do |day|
    	
			graphic_data.push(Control.graphic_data_for_a_day(day.to_s, current_user.id))
			

		end
    	
		
		
		
	 render json: graphic_data.to_json

	end





end





