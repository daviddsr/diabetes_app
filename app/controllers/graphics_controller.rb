class GraphicsController < ApplicationController
	def index

	end

	def graphics_evolution
		
    graphic_data = Control.graphic_data_for_a_day "2014-11-21"
    
  #   dates=[]

  #   Control.all.each { |control| dates << control.day.strftime("%d-%m-%Y") }
		
		

  #   days = []

  #   dates.each do |date|
  #   	unless days.include?(date)
  #   		days.push(date)
  #   	end
  #   end

  #   graphic_data=[]

  #   days.each do |day|
  #   	puts day
		# 	graphic_data.push(Control.graphic_data_for_a_day day.to_s)

		# end
    	
		
		
		
	 render json: graphic_data.to_json

	end





end





