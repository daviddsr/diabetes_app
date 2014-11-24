class GraphicsController < ApplicationController
	def index

	end

	def graphics_evolution
		
     # graphic_data = Control.graphic_data_for_a_day "2014-11-21"
    
    	# puts graphic_data
    dates= Control.all.map { |control| control.day.strftime("%d-%m-%Y") }
		
		

    days = []

    dates.each do |date|
    	unless days.include?(date)
    		days.push(date)
    	end

    end


    graphic_data=[]

    days.each do |day|
    	puts days
			graphic_data.push(Control.graphic_data_for_a_day day.to_s)
			puts graphic_data

		end
    	
		
		
		
	 render json: graphic_data.to_json

	end





end





